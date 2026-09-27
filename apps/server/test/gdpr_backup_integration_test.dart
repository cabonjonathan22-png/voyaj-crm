@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'support/test_server.dart';

/// RGPD (export, anonymisation) et sauvegardes.
void main() {
  if (integrationSkip != null) {
    test('intégration', () {}, skip: integrationSkip);
    return;
  }
  late TestServer server;
  final backupDir = Directory.systemTemp.createTempSync('voyaj-backups');

  setUpAll(
    () async => server = await TestServer.start(
      extraConfig: {'VOYAJ_BACKUP_DIR': backupDir.path},
    ),
  );
  tearDownAll(() async {
    await server.close();
    backupDir.deleteSync(recursive: true);
  });

  test('export puis anonymisation d’un contact', () async {
    final admin = await server.admin();
    final contactId = newId();
    final activityId = newId();
    await admin.push([
      admin.op(contactId, {
        'last_name': 'Durand',
        'first_name': 'Anne',
        'email': 'anne.durand@rodez.fr',
        'phone': '05 65 00 00 00',
      }, entity: 'contacts'),
      admin.op(activityId, {
        'kind': 'call',
        'subject': 'Appel avec Anne Durand',
        'body': 'Numéro personnel : 06…',
        'contact_id': contactId,
      }, entity: 'activities'),
    ]);

    final export = await http.get(
      server.baseUri.resolve('/api/v1/gdpr/contacts/$contactId/export'),
      headers: {'authorization': 'Bearer ${admin.tokens!.accessToken}'},
    );
    expect(export.statusCode, 200);
    final data = jsonDecode(export.body) as Map<String, dynamic>;
    expect((data['contact'] as Map)['email'], 'anne.durand@rodez.fr');
    expect(
      ((data['activities'] as List).single as Map)['subject'],
      contains('Anne'),
    );

    expect(
      (await admin.post('/api/v1/gdpr/contacts/$contactId/erase')).status,
      204,
    );
    final records = (await admin.pull(0)).records;
    final contact = records.lastWhere((r) => r.id == contactId).data;
    expect(contact['last_name'], 'Contact anonymisé');
    expect(contact['email'], isNull);
    expect(contact['do_not_contact'], isTrue);
    final activity = records.lastWhere((r) => r.id == activityId).data;
    expect(activity['body'], isNull);
    expect(activity['subject'], 'Activité anonymisée');

    // Plus aucune trace dans l'historique des modifications.
    final again = await http.get(
      server.baseUri.resolve('/api/v1/gdpr/contacts/$contactId/export'),
      headers: {'authorization': 'Bearer ${admin.tokens!.accessToken}'},
    );
    expect(again.body, isNot(contains('anne.durand')));
    final history = await server.server.services.db.query(
      "SELECT fields::text FROM change_log WHERE entity_id = '$contactId'",
    );
    expect(history.map((r) => r.first).join(), isNot(contains('Durand')));

    final commercial = await server.userWithRoles('rgpd@voyaj.test', [
      'commercial',
    ]);
    expect(
      (await commercial.post('/api/v1/gdpr/contacts/$contactId/erase')).status,
      403,
    );
  });

  test('sauvegarde : base et fichiers joints', () async {
    final admin = await server.admin();
    final upload = await admin.upload(utf8.encode('pièce jointe'));
    expect(upload.status, 201);

    final created = await admin.post('/api/v1/admin/backups');
    expect(created.status, 201, reason: '${created.body}');
    final info = BackupInfo.fromJson(created.json);
    expect(info.databaseBytes, greaterThan(1000));
    expect(info.newFiles, 1);
    expect(
      File(p.join(backupDir.path, '${info.name}.dump')).existsSync(),
      isTrue,
    );

    final status = BackupStatus.fromJson(
      (await admin.get('/api/v1/admin/backups')).json,
    );
    expect(status.backups.single.name, info.name);
    expect(status.hour, isNull);

    // Fichiers déjà copiés : rien de nouveau.
    await Future<void>.delayed(const Duration(seconds: 1));
    final second = BackupInfo.fromJson(
      (await admin.post('/api/v1/admin/backups')).json,
    );
    expect(second.newFiles, 0);
    expect(second.totalFiles, 1);
  });
}
