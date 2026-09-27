@Tags(['integration'])
library;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:voyaj_server/voyaj_server.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'support/test_server.dart';

/// Serveur de messagerie simulé : boîte de réception en mémoire, emails
/// envoyés conservés.
final class FakeMailTransport implements MailTransport {
  final inbox = <FetchedMail>[];
  final sent = <(MailCredentials, OutgoingMail)>[];
  int uidValidity = 1;
  String? failWith;

  @override
  Future<void> verify(MailCredentials credentials) async {
    if (credentials.secret == 'mauvais') {
      throw const MailException('Serveur IMAP : identifiants refusés.');
    }
  }

  @override
  Future<InboxBatch> fetchInbox(
    MailCredentials credentials, {
    required int? uidValidity,
    required int lastUid,
    required DateTime since,
    int limit = 200,
  }) async {
    if (failWith != null) throw MailException(failWith!);
    return InboxBatch(
      uidValidity: this.uidValidity,
      messages: [
        for (final m in inbox)
          if (m.uid > lastUid || uidValidity != this.uidValidity) m,
      ],
    );
  }

  @override
  Future<String> send(MailCredentials credentials, OutgoingMail mail) async {
    sent.add((credentials, mail));
    return '<${sent.length}@voyaj.test>';
  }
}

FetchedMail mail(
  int uid,
  String from,
  String subject, {
  String to = 'alice@voyaj.test',
  DateTime? date,
}) => FetchedMail(
  uid: uid,
  messageId: '<in-$uid@test>',
  from: EmailAddress(address: from, name: 'Expéditeur $uid'),
  to: [EmailAddress(address: to)],
  subject: subject,
  text: 'Bonjour,\n\nMessage $uid.',
  date: date ?? DateTime.now().toUtc(),
);

void main() {
  if (integrationSkip != null) {
    test('intégration', () {}, skip: integrationSkip);
    return;
  }
  final transport = FakeMailTransport();
  final tokenRequests = <Map<String, String>>[];
  late TestServer server;

  setUpAll(() async {
    final idToken = [
      base64Url.encode(utf8.encode('{"alg":"none"}')),
      base64Url.encode(
        utf8.encode('{"email":"Alice.Gmail@gmail.com","name":"Alice"}'),
      ),
      'sig',
    ].join('.');
    server = await TestServer.start(
      mailTransport: transport,
      oauthClient: OAuthClient(
        httpClient: MockClient((request) async {
          tokenRequests.add(request.bodyFields);
          return http.Response(
            jsonEncode({
              'access_token': 'acces-${tokenRequests.length}',
              'refresh_token': 'rafraichissement',
              'expires_in': 3600,
              'id_token': idToken,
            }),
            200,
          );
        }),
      ),
      extraConfig: {
        'VOYAJ_PUBLIC_URL': 'https://crm.voyaj.test',
        'VOYAJ_GOOGLE_CLIENT_ID': 'client-google',
        'VOYAJ_GOOGLE_CLIENT_SECRET': 'secret-google',
      },
    );
  });
  tearDownAll(() => server.close());

  EmailService service() => server.server.services.email;

  Future<String> accountIdOf(ApiClient client) async =>
      ((await client.get('/api/v1/email/accounts')).list.first
              as Map<String, dynamic>)['id']
          as String;

  Future<String> createAccount(
    ApiClient client, {
    String password = 'ok',
  }) async {
    final response = await client.post(
      '/api/v1/email/accounts',
      const CreateImapAccountRequest(
        address: 'Admin@Voyaj.test',
        displayName: 'Admin Voyaj',
        imapHost: 'imap.voyaj.test',
        smtpHost: 'smtp.voyaj.test',
        username: 'admin',
        password: 'ok',
      ).copyWith(password: password).toJson(),
    );
    if (response.status != 201) throw StateError('${response.body}');
    return response.json['id'] as String;
  }

  Future<String> createContact(
    ApiClient client,
    String email, {
    String last = 'Durand',
  }) async {
    final orgId = newId();
    final contactId = newId();
    await client.push([
      client.op(orgId, {
        'name': 'Mairie de $last',
        'kind': 'commune',
        'status': 'contacte',
      }, entity: 'organisations'),
      client.op(contactId, {
        'last_name': last,
        'first_name': 'Anne',
        'civility': 'Mme',
        'email': email,
        'organisation_id': orgId,
      }, entity: 'contacts'),
    ]);
    return contactId;
  }

  test('compte IMAP : connexion vérifiée, secret jamais renvoyé', () async {
    final admin = await server.admin();
    final refused = await admin.post(
      '/api/v1/email/accounts',
      const CreateImapAccountRequest(
        address: 'x@voyaj.test',
        imapHost: 'imap',
        smtpHost: 'smtp',
        username: 'x',
        password: 'mauvais',
      ).toJson(),
    );
    expect(refused.status, 400);
    expect(refused.json['message'], contains('identifiants refusés'));

    final id = await createAccount(admin);
    final list = await admin.get('/api/v1/email/accounts');
    final account = list.list.single as Map<String, dynamic>;
    expect(account['id'], id);
    expect(account['address'], 'admin@voyaj.test');
    expect(jsonEncode(list.body), isNot(contains('ok')));

    // Un autre utilisateur ne voit pas ce compte.
    final other = await server.userWithRoles('mail-commercial@voyaj.test', [
      'commercial',
    ]);
    expect((await other.get('/api/v1/email/accounts')).list, isEmpty);
    expect((await other.post('/api/v1/email/accounts/$id/sync')).status, 404);
  });

  test('réception : message d’un contact journalisé en activité', () async {
    final admin = await server.admin();
    final accountId = await accountIdOf(admin);
    final contactId = await createContact(admin, 'anne.durand@rodez.fr');
    transport.inbox
      ..add(
        mail(
          10,
          'Anne.Durand@rodez.fr',
          'Votre proposition',
          to: 'admin@voyaj.test',
        ),
      )
      ..add(
        mail(11, 'newsletter@exemple.fr', 'Promotions', to: 'admin@voyaj.test'),
      );

    final synced = await admin.post('/api/v1/email/accounts/$accountId/sync');
    expect(synced.status, 200);
    expect(synced.json['last_error'], isNull);

    final messages = await admin.get('/api/v1/email/messages');
    final fromContact = messages.list.cast<Map<String, dynamic>>().firstWhere(
      (m) => m['subject'] == 'Votre proposition',
    );
    expect(fromContact['contact_id'], contactId);
    expect(fromContact['activity_id'], isNotNull);
    expect(fromContact['body_text'], isNull);
    final newsletter = messages.list.cast<Map<String, dynamic>>().firstWhere(
      (m) => m['subject'] == 'Promotions',
    );
    expect(newsletter['activity_id'], isNull);

    final detail = await admin.get(
      '/api/v1/email/messages/${fromContact['id']}',
    );
    expect(detail.json['body_text'], contains('Message 10'));
    expect(detail.json['read'], isTrue);

    // L'activité est synchronisée vers les postes.
    final activities = [
      for (final r in (await admin.pull(0)).records)
        if (r.entity == 'activities') r,
    ];
    final activity = activities.firstWhere(
      (a) => a.id == fromContact['activity_id'],
    );
    expect(activity.data['kind'], 'email');
    expect(activity.data['contact_id'], contactId);
    expect(activity.data['subject'], 'Votre proposition');

    // Deuxième synchronisation : pas de doublon.
    await admin.post('/api/v1/email/accounts/$accountId/sync');
    expect((await admin.get('/api/v1/email/messages')).list, hasLength(2));
  });

  test('envoi : message enregistré et activité créée', () async {
    final admin = await server.admin();
    final accountId = await accountIdOf(admin);
    final contactId = await createContact(
      admin,
      'paul@millau.fr',
      last: 'Martin',
    );
    final response = await admin.post(
      '/api/v1/email/send',
      SendEmailRequest(
        accountId: accountId,
        to: ['Paul@Millau.fr'],
        subject: 'Rendez-vous',
        body: 'Bonjour Paul,',
      ).toJson(),
    );
    expect(response.status, 201, reason: '${response.body}');
    expect(response.json['direction'], 'out');
    expect(response.json['contact_id'], contactId);
    expect(response.json['activity_id'], isNotNull);
    final (credentials, sent) = transport.sent.last;
    expect(credentials.secret, 'ok');
    expect(sent.to, ['paul@millau.fr']);

    final invalid = await admin.post(
      '/api/v1/email/send',
      SendEmailRequest(
        accountId: accountId,
        to: ['pas-une-adresse'],
        subject: '',
        body: '',
      ).toJson(),
    );
    expect(invalid.status, 422);
  });

  test('séquence : étapes envoyées, arrêt à la réponse', () async {
    final admin = await server.admin();
    final me = await admin.get('/api/v1/auth/me');
    final ownerId = me.json['id'] as String;
    final contactId = await createContact(admin, 'lea@tulle.fr', last: 'Petit');
    final t1 = newId();
    final t2 = newId();
    final sequenceId = newId();
    final enrollmentId = newId();
    final results = (await admin.push([
      admin.op(t1, {
        'name': 'Premier contact',
        'subject': 'Mobilité à {{organisation.name}}',
        'body': 'Bonjour {{contact.civility}} {{contact.last_name}},',
      }, entity: 'email_templates'),
      admin.op(t2, {
        'name': 'Relance',
        'subject': 'Relance',
        'body': 'Je me permets de revenir vers vous. {{user.name}}',
      }, entity: 'email_templates'),
      admin.op(sequenceId, {
        'name': 'Prospection',
        'steps': [
          {'delay_days': 0, 'template_id': t1},
          {'delay_days': 5, 'template_id': t2},
        ],
        'active': true,
      }, entity: 'email_sequences'),
      admin.op(enrollmentId, {
        'sequence_id': sequenceId,
        'contact_id': contactId,
        'owner_id': ownerId,
        'step': 0,
        'status': 'active',
        'next_send_at': DateTime.now()
            .toUtc()
            .subtract(const Duration(minutes: 1))
            .toIso8601String(),
      }, entity: 'sequence_enrollments'),
    ])).results;
    expect(results.map((r) => r.status), everyElement(OpStatus.applied));

    expect(await service().processSequences(), 1);
    final (_, first) = transport.sent.last;
    expect(first.to, ['lea@tulle.fr']);
    expect(first.subject, 'Mobilité à Mairie de Petit');
    expect(first.body, 'Bonjour Mme Petit,');

    Future<SyncRecord> enrollment() async =>
        (await admin.pull(0)).records.lastWhere((r) => r.id == enrollmentId);
    var state = await enrollment();
    expect(state.data['step'], 1);
    expect(state.data['status'], 'active');
    final next = DateTime.parse(state.data['next_send_at']! as String);
    expect(next.difference(DateTime.now().toUtc()).inDays, 4);

    // Rien d'autre n'est dû avant 5 jours.
    expect(await service().processSequences(), 0);

    // Le contact répond : la séquence s'arrête.
    final accountId = await accountIdOf(admin);
    transport.inbox.add(
      mail(20, 'lea@tulle.fr', 'Re: Mobilité', to: 'admin@voyaj.test'),
    );
    await admin.post('/api/v1/email/accounts/$accountId/sync');
    state = await enrollment();
    expect(state.data['status'], 'replied');
  });

  test('séquence : contact sans email → échec lisible', () async {
    final admin = await server.admin();
    final me = await admin.get('/api/v1/auth/me');
    final contactId = newId();
    final template = newId();
    final sequence = newId();
    final enrollmentId = newId();
    await admin.push([
      admin.op(contactId, {'last_name': 'Sansmail'}, entity: 'contacts'),
      admin.op(template, {
        'name': 'T',
        'subject': 'S',
        'body': 'B',
      }, entity: 'email_templates'),
      admin.op(sequence, {
        'name': 'Seq',
        'steps': [
          {'delay_days': 0, 'template_id': template},
        ],
      }, entity: 'email_sequences'),
      admin.op(enrollmentId, {
        'sequence_id': sequence,
        'contact_id': contactId,
        'owner_id': me.json['id'],
        'step': 0,
        'status': 'active',
        'next_send_at': DateTime.now().toUtc().toIso8601String(),
      }, entity: 'sequence_enrollments'),
    ]);
    await service().processSequences();
    final state = (await admin.pull(0)).records
        .lastWhere((r) => r.id == enrollmentId);
    expect(state.data['status'], 'failed');
    expect(state.data['last_error'], 'Le contact n’a pas d’email.');
  });

  test('erreur de synchronisation enregistrée sur le compte', () async {
    final admin = await server.admin();
    final accountId = await accountIdOf(admin);
    transport.failWith = 'Serveur IMAP : délai dépassé.';
    addTearDown(() => transport.failWith = null);
    final response = await admin.post('/api/v1/email/accounts/$accountId/sync');
    expect(response.json['last_error'], 'Serveur IMAP : délai dépassé.');
  });

  test('OAuth Google : autorisation, compte créé, jeton renouvelé', () async {
    final admin = await server.admin();
    expect(
      (await admin.get('/api/v1/email/providers')).list,
      containsAll(['imap', 'google']),
    );
    expect(
      (await admin.get('/api/v1/email/oauth/microsoft/start')).status,
      400,
    );
    final start = await admin.get('/api/v1/email/oauth/google/start');
    final url = Uri.parse(start.json['url'] as String);
    expect(url.host, 'accounts.google.com');
    expect(url.queryParameters['client_id'], 'client-google');
    expect(
      url.queryParameters['redirect_uri'],
      'https://crm.voyaj.test/api/v1/email/oauth/callback',
    );
    expect(url.queryParameters['access_type'], 'offline');

    // Retour du navigateur (non authentifié).
    final callback = await http.get(
      server.baseUri.resolve(
        '/api/v1/email/oauth/callback?code=abc&state='
        '${url.queryParameters['state']}',
      ),
    );
    expect(callback.statusCode, 200);
    expect(callback.body, contains('alice.gmail@gmail.com'));
    expect(tokenRequests.last['grant_type'], 'authorization_code');
    expect(tokenRequests.last['code'], 'abc');

    // Réutilisation de l'état : refusée.
    final replay = await http.get(
      server.baseUri.resolve(
        '/api/v1/email/oauth/callback?code=abc&state='
        '${url.queryParameters['state']}',
      ),
    );
    expect(replay.statusCode, 400);

    final accounts = (await admin.get('/api/v1/email/accounts')).list
        .cast<Map<String, dynamic>>();
    final gmail = accounts.firstWhere((a) => a['provider'] == 'google');
    expect(gmail['address'], 'alice.gmail@gmail.com');

    // Envoi : jeton d'accès en cache utilisé (XOAUTH2).
    await admin.post(
      '/api/v1/email/send',
      SendEmailRequest(
        accountId: gmail['id'] as String,
        to: ['quelquun@exemple.fr'],
        subject: 'Test',
        body: '…',
      ).toJson(),
    );
    final (credentials, _) = transport.sent.last;
    expect(credentials.oauth, isTrue);
    expect(credentials.imapHost, 'imap.gmail.com');
    expect(credentials.secret, startsWith('acces-'));
  });
}
