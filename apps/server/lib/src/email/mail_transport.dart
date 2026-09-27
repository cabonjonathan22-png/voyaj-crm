import 'package:enough_mail/enough_mail.dart';
import 'package:meta/meta.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

/// Paramètres de connexion d'un compte (secret déchiffré).
@immutable
final class MailCredentials {
  const MailCredentials({
    required this.address,
    required this.username,
    required this.secret,
    required this.imapHost,
    required this.imapPort,
    required this.imapTls,
    required this.smtpHost,
    required this.smtpPort,
    required this.smtpSecurity,
    this.displayName,
    this.oauth = false,
  });

  final String address;
  final String? displayName;
  final String username;

  /// Mot de passe, ou jeton d'accès OAuth si [oauth].
  final String secret;
  final bool oauth;
  final String imapHost;
  final int imapPort;
  final bool imapTls;
  final String smtpHost;
  final int smtpPort;
  final SmtpSecurity smtpSecurity;
}

/// Email lu dans la boîte de réception.
@immutable
final class FetchedMail {
  const FetchedMail({
    required this.uid,
    required this.from,
    required this.to,
    required this.subject,
    required this.text,
    required this.date,
    this.cc = const [],
    this.messageId,
    this.inReplyTo,
  });

  final int uid;
  final String? messageId;
  final String? inReplyTo;
  final EmailAddress from;
  final List<EmailAddress> to;
  final List<EmailAddress> cc;
  final String subject;
  final String text;
  final DateTime date;
}

/// Nouveaux messages de la boîte de réception.
@immutable
final class InboxBatch {
  const InboxBatch({required this.uidValidity, required this.messages});

  final int uidValidity;
  final List<FetchedMail> messages;
}

/// Email à envoyer.
@immutable
final class OutgoingMail {
  const OutgoingMail({
    required this.to,
    required this.subject,
    required this.body,
    this.cc = const [],
    this.inReplyTo,
  });

  final List<String> to;
  final List<String> cc;
  final String subject;
  final String body;
  final String? inReplyTo;
}

/// Erreur de messagerie (message en français).
final class MailException implements Exception {
  const MailException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Accès aux serveurs de messagerie (remplaçable dans les tests).
abstract interface class MailTransport {
  /// Vérifie la connexion IMAP et SMTP.
  Future<void> verify(MailCredentials credentials);

  /// Messages de la boîte de réception après [lastUid] (ou depuis [since]
  /// au premier passage, ou si [uidValidity] a changé), au plus [limit].
  Future<InboxBatch> fetchInbox(
    MailCredentials credentials, {
    required int? uidValidity,
    required int lastUid,
    required DateTime since,
    int limit = 200,
  });

  /// Envoie [mail] ; retourne son `Message-ID`.
  Future<String> send(MailCredentials credentials, OutgoingMail mail);
}

/// Implémentation IMAP / SMTP (enough_mail).
final class ImapSmtpTransport implements MailTransport {
  const ImapSmtpTransport();

  static const _timeout = Duration(seconds: 30);

  Future<T> _imap<T>(
    MailCredentials c,
    Future<T> Function(ImapClient client) action,
  ) async {
    final client = ImapClient();
    try {
      await client.connectToServer(
        c.imapHost,
        c.imapPort,
        isSecure: c.imapTls,
        timeout: _timeout,
      );
      if (c.oauth) {
        await client.authenticateWithOAuth2(c.username, c.secret);
      } else {
        await client.login(c.username, c.secret);
      }
      final result = await action(client);
      await client.logout();
      return result;
    } on ImapException catch (e) {
      throw MailException('Serveur IMAP : ${e.message ?? e}');
    } on MailException {
      rethrow;
    } on Object catch (e) {
      throw MailException('Connexion IMAP impossible ($e).');
    } finally {
      await client.disconnect();
    }
  }

  Future<T> _smtp<T>(
    MailCredentials c,
    Future<T> Function(SmtpClient client) action,
  ) async {
    final client = SmtpClient('voyaj.local');
    try {
      await client.connectToServer(
        c.smtpHost,
        c.smtpPort,
        isSecure: c.smtpSecurity == SmtpSecurity.tls,
        timeout: _timeout,
      );
      await client.ehlo();
      if (c.smtpSecurity == SmtpSecurity.starttls) {
        await client.startTls();
      }
      await client.authenticate(
        c.username,
        c.secret,
        c.oauth ? AuthMechanism.xoauth2 : AuthMechanism.plain,
      );
      final result = await action(client);
      await client.quit();
      return result;
    } on SmtpException catch (e) {
      throw MailException('Serveur SMTP : ${e.message}');
    } on MailException {
      rethrow;
    } on Object catch (e) {
      throw MailException('Connexion SMTP impossible ($e).');
    } finally {
      await client.disconnect();
    }
  }

  @override
  Future<void> verify(MailCredentials credentials) async {
    await _imap(credentials, (client) => client.selectInbox());
    await _smtp(credentials, (_) async {});
  }

  @override
  Future<InboxBatch> fetchInbox(
    MailCredentials credentials, {
    required int? uidValidity,
    required int lastUid,
    required DateTime since,
    int limit = 200,
  }) => _imap(credentials, (client) async {
    final box = await client.selectInbox();
    final validity = box.uidValidity ?? 0;
    final List<int> uids;
    if (uidValidity == validity && lastUid > 0) {
      if ((box.uidNext ?? 0) <= lastUid + 1) {
        return InboxBatch(uidValidity: validity, messages: const []);
      }
      final search = await client.uidSearchMessages(
        searchCriteria: 'UID ${lastUid + 1}:*',
      );
      uids = [
        for (final uid in search.matchingSequence?.toList() ?? const <int>[])
          if (uid > lastUid) uid,
      ];
    } else {
      final search = await client.uidSearchMessages(
        searchCriteria: 'SINCE ${_imapDate(since)}',
      );
      uids = search.matchingSequence?.toList() ?? const [];
    }
    if (uids.isEmpty) {
      return InboxBatch(uidValidity: validity, messages: const []);
    }
    final selected = (uids..sort()).reversed.take(limit).toList();
    final fetched = await client.uidFetchMessages(
      MessageSequence.fromIds(selected, isUid: true),
      'BODY.PEEK[]',
    );
    return InboxBatch(
      uidValidity: validity,
      messages: [for (final m in fetched.messages) _toFetched(m)],
    );
  });

  @override
  Future<String> send(MailCredentials credentials, OutgoingMail mail) =>
      _smtp(credentials, (client) async {
        final builder = MessageBuilder()
          ..from = [MailAddress(credentials.displayName, credentials.address)]
          ..to = [for (final a in mail.to) MailAddress(null, a)]
          ..cc = [for (final a in mail.cc) MailAddress(null, a)]
          ..subject = mail.subject
          ..text = mail.body;
        if (mail.inReplyTo != null) {
          builder
            ..setHeader(MailConventions.headerInReplyTo, mail.inReplyTo)
            ..setHeader(MailConventions.headerReferences, mail.inReplyTo);
        }
        final message = builder.buildMimeMessage();
        await client.sendMessage(message, use8BitEncoding: true);
        return message.getHeaderValue(MailConventions.headerMessageId) ?? '';
      });

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static String _imapDate(DateTime d) =>
      '${d.day}-${_months[d.month - 1]}-${d.year}';

  static EmailAddress _address(MailAddress a) =>
      EmailAddress(address: a.email.toLowerCase(), name: a.personalName);

  static FetchedMail _toFetched(MimeMessage m) {
    final text =
        m.decodeTextPlainPart() ?? _stripHtml(m.decodeTextHtmlPart() ?? '');
    return FetchedMail(
      uid: m.uid ?? 0,
      messageId: m.getHeaderValue(MailConventions.headerMessageId),
      inReplyTo: m.getHeaderValue(MailConventions.headerInReplyTo),
      from: m.from?.isNotEmpty ?? false
          ? _address(m.from!.first)
          : const EmailAddress(address: ''),
      to: [for (final a in m.to ?? const <MailAddress>[]) _address(a)],
      cc: [for (final a in m.cc ?? const <MailAddress>[]) _address(a)],
      subject: m.decodeSubject() ?? '',
      text: text,
      date: (m.decodeDate() ?? DateTime.now()).toUtc(),
    );
  }
}

/// Texte brut approximatif d'un corps HTML.
String _stripHtml(String html) => html
    .replaceAll(RegExp(r'<(br|/p|/div)[^>]*>', caseSensitive: false), '\n')
    .replaceAll(RegExp('<[^>]+>'), '')
    .replaceAll('&nbsp;', ' ')
    .replaceAll('&amp;', '&')
    .replaceAll('&lt;', '<')
    .replaceAll('&gt;', '>')
    .replaceAll(RegExp(r'\n{3,}'), '\n\n')
    .trim();
