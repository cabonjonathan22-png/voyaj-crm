import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'mail_transport.dart';

/// Application OAuth d'un fournisseur (identifiants dans la
/// configuration du serveur) et paramètres de ses serveurs de messagerie.
@immutable
final class OAuthApp {
  const OAuthApp({
    required this.provider,
    required this.authorizeUrl,
    required this.tokenUrl,
    required this.clientId,
    required this.clientSecret,
    required this.scopes,
    required this.imapHost,
    required this.smtpHost,
    required this.smtpPort,
    required this.smtpSecurity,
    this.extraParams = const {},
  });

  /// Google (Gmail) : IMAP / SMTP avec XOAUTH2.
  factory OAuthApp.google({
    required String clientId,
    required String clientSecret,
  }) => OAuthApp(
    provider: EmailProvider.google,
    authorizeUrl: 'https://accounts.google.com/o/oauth2/v2/auth',
    tokenUrl: 'https://oauth2.googleapis.com/token',
    clientId: clientId,
    clientSecret: clientSecret,
    scopes: const ['https://mail.google.com/', 'openid', 'email', 'profile'],
    imapHost: 'imap.gmail.com',
    smtpHost: 'smtp.gmail.com',
    smtpPort: 465,
    smtpSecurity: SmtpSecurity.tls,
    extraParams: const {'access_type': 'offline', 'prompt': 'consent'},
  );

  /// Microsoft 365 / Outlook : IMAP / SMTP avec XOAUTH2.
  factory OAuthApp.microsoft({
    required String clientId,
    required String clientSecret,
    String tenant = 'common',
  }) => OAuthApp(
    provider: EmailProvider.microsoft,
    authorizeUrl:
        'https://login.microsoftonline.com/$tenant/oauth2/v2.0/authorize',
    tokenUrl: 'https://login.microsoftonline.com/$tenant/oauth2/v2.0/token',
    clientId: clientId,
    clientSecret: clientSecret,
    scopes: const [
      'offline_access',
      'openid',
      'email',
      'profile',
      'https://outlook.office.com/IMAP.AccessAsUser.All',
      'https://outlook.office.com/SMTP.Send',
    ],
    imapHost: 'outlook.office365.com',
    smtpHost: 'smtp.office365.com',
    smtpPort: 587,
    smtpSecurity: SmtpSecurity.starttls,
    extraParams: const {'prompt': 'select_account'},
  );

  final EmailProvider provider;
  final String authorizeUrl;
  final String tokenUrl;
  final String clientId;
  final String clientSecret;
  final List<String> scopes;
  final String imapHost;
  final String smtpHost;
  final int smtpPort;
  final SmtpSecurity smtpSecurity;
  final Map<String, String> extraParams;

  Uri authorizationUri({required String redirectUri, required String state}) =>
      Uri.parse(authorizeUrl).replace(
        queryParameters: {
          'client_id': clientId,
          'redirect_uri': redirectUri,
          'response_type': 'code',
          'scope': scopes.join(' '),
          'state': state,
          ...extraParams,
        },
      );
}

/// Jetons obtenus d'un fournisseur OAuth.
@immutable
final class OAuthTokens {
  const OAuthTokens({
    required this.accessToken,
    required this.expiresAt,
    this.refreshToken,
    this.email,
    this.name,
  });

  final String accessToken;
  final String? refreshToken;
  final DateTime expiresAt;

  /// Adresse et nom lus dans le jeton d'identité (échange du code).
  final String? email;
  final String? name;
}

/// Échanges avec le point de jetons OAuth.
final class OAuthClient {
  OAuthClient({http.Client? httpClient, DateTime Function()? clock})
    : _http = httpClient ?? http.Client(),
      _clock = clock ?? DateTime.now;

  final http.Client _http;
  final DateTime Function() _clock;

  Future<OAuthTokens> exchangeCode(
    OAuthApp app, {
    required String code,
    required String redirectUri,
  }) => _token(app, {
    'grant_type': 'authorization_code',
    'code': code,
    'redirect_uri': redirectUri,
  });

  Future<OAuthTokens> refresh(OAuthApp app, String refreshToken) => _token(
    app,
    {'grant_type': 'refresh_token', 'refresh_token': refreshToken},
  );

  Future<OAuthTokens> _token(OAuthApp app, Map<String, String> params) async {
    final http.Response response;
    try {
      response = await _http
          .post(
            Uri.parse(app.tokenUrl),
            body: {
              ...params,
              'client_id': app.clientId,
              'client_secret': app.clientSecret,
            },
          )
          .timeout(const Duration(seconds: 20));
    } on Object {
      throw const MailException('Fournisseur OAuth injoignable.');
    }
    final Object? json;
    try {
      json = jsonDecode(response.body);
    } on FormatException {
      throw MailException('Réponse OAuth illisible (${response.statusCode}).');
    }
    if (response.statusCode != 200 ||
        json is! Map<String, dynamic> ||
        json['access_token'] is! String) {
      final error = json is Map
          ? json['error_description'] ?? json['error']
          : null;
      throw MailException(
        'Autorisation refusée${error == null ? '' : ' : $error'}.',
      );
    }
    final identity = _decodeJwt(json['id_token'] as String?);
    return OAuthTokens(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
      expiresAt: _clock().toUtc().add(
        Duration(seconds: (json['expires_in'] as num?)?.toInt() ?? 3600),
      ),
      email: (identity['email'] ?? identity['preferred_username']) as String?,
      name: identity['name'] as String?,
    );
  }

  /// Contenu (non vérifié) d'un jeton d'identité reçu directement du
  /// fournisseur sur une connexion TLS.
  static Map<String, dynamic> _decodeJwt(String? token) {
    final parts = token?.split('.');
    if (parts == null || parts.length != 3) return const {};
    try {
      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      return (jsonDecode(payload) as Map).cast<String, dynamic>();
    } on Object {
      return const {};
    }
  }

  void close() => _http.close();
}
