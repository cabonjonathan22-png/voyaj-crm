import 'package:voyaj_shared/voyaj_shared.dart';

/// Erreur métier traduite en réponse HTTP JSON ([ApiError]).
final class ApiException implements Exception {
  const ApiException(
    this.status,
    this.code,
    this.message, {
    this.issues = const [],
  });

  const ApiException.badRequest(String message)
    : this(400, ApiErrorCodes.badRequest, message);

  const ApiException.validation(
    List<ValidationIssue> issues, [
    String message = 'Données invalides.',
  ]) : this(422, ApiErrorCodes.validation, message, issues: issues);

  const ApiException.unauthenticated([
    String message = 'Authentification requise.',
  ]) : this(401, ApiErrorCodes.unauthenticated, message);

  const ApiException.forbidden([
    String message = "Vous n'avez pas les droits nécessaires.",
  ]) : this(403, ApiErrorCodes.forbidden, message);

  const ApiException.notFound([String message = 'Ressource introuvable.'])
    : this(404, ApiErrorCodes.notFound, message);

  const ApiException.conflict(String message)
    : this(409, ApiErrorCodes.conflict, message);

  const ApiException.tooManyAttempts()
    : this(
        429,
        ApiErrorCodes.tooManyAttempts,
        'Trop de tentatives. Réessayez dans quelques minutes.',
      );

  final int status;
  final String code;
  final String message;
  final List<ValidationIssue> issues;

  ApiError toApiError() =>
      ApiError(code: code, message: message, issues: issues);

  @override
  String toString() => 'ApiException($status, $code, $message)';
}
