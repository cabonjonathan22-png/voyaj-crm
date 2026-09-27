import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:voyaj_shared/voyaj_shared.dart';

import '../auth/auth_context.dart';
import '../db/database.dart';
import '../errors.dart';

/// Taille maximale d'un fichier joint.
const maxFileBytes = 25 * 1024 * 1024;

/// Fichiers joints : contenu sur disque, adressé par son empreinte SHA-256
/// (un même fichier envoyé deux fois n'est stocké qu'une fois). Les
/// métadonnées visibles (nom, rattachement) sont l'entité synchronisée
/// `attachments`.
final class FileStore {
  FileStore({required this._db, required String dataDir})
    : _root = Directory(p.join(dataDir, 'files'));

  final Database _db;
  final Directory _root;

  File _fileFor(String id) =>
      File(p.join(_root.path, id.substring(0, 2), id.substring(2)));

  /// Enregistre le contenu reçu et retourne son identifiant.
  Future<({String id, int size})> upload(
    AuthContext ctx,
    Stream<List<int>> body, {
    String? mimeType,
  }) async {
    ctx.require(Permission.activityWrite);
    await _root.create(recursive: true);
    final temp = File(
      p.join(_root.path, 'upload-${DateTime.now().microsecondsSinceEpoch}'),
    );
    final sink = temp.openWrite();
    final digest = _DigestSink();
    final hasher = sha256.startChunkedConversion(digest);
    var size = 0;
    try {
      await for (final chunk in body) {
        size += chunk.length;
        if (size > maxFileBytes) {
          throw const ApiException(
            413,
            'payload_too_large',
            'Fichier trop volumineux (25 Mo maximum).',
          );
        }
        hasher.add(chunk);
        sink.add(chunk);
      }
      hasher.close();
      await sink.close();
    } catch (_) {
      await sink.close();
      if (temp.existsSync()) await temp.delete();
      rethrow;
    }

    final id = digest.value.toString();
    final target = _fileFor(id);
    if (target.existsSync()) {
      await temp.delete();
    } else {
      await target.parent.create(recursive: true);
      await temp.rename(target.path);
    }
    await _db.query(
      'INSERT INTO files (id, size, mime_type, uploaded_by) '
      'VALUES (@id, @size, @mime, @user) ON CONFLICT (id) DO NOTHING',
      {'id': id, 'size': size, 'mime': mimeType, 'user': ctx.userId},
    );
    return (id: id, size: size);
  }

  /// Enregistre un contenu produit par le serveur (ex. PDF de facture) ;
  /// retourne son identifiant.
  Future<String> storeBytes(
    List<int> bytes, {
    String? mimeType,
    String? userId,
  }) async {
    final id = sha256.convert(bytes).toString();
    final target = _fileFor(id);
    if (!target.existsSync()) {
      await target.parent.create(recursive: true);
      final temp = File('${target.path}.tmp');
      await temp.writeAsBytes(bytes, flush: true);
      await temp.rename(target.path);
    }
    await _db.query(
      'INSERT INTO files (id, size, mime_type, uploaded_by) '
      'VALUES (@id, @size, @mime, @user) ON CONFLICT (id) DO NOTHING',
      {'id': id, 'size': bytes.length, 'mime': mimeType, 'user': userId},
    );
    return id;
  }

  /// Contenu d'un fichier (et son type), ou [ApiException.notFound].
  /// Fichiers joints : droit de lecture des activités ; [permission]
  /// remplace ce droit pour d'autres usages (PDF de facture).
  Future<({File file, String? mimeType})> open(
    AuthContext ctx,
    String id, {
    Permission permission = Permission.activityRead,
  }) async {
    ctx.require(permission);
    if (!RegExp(r'^[0-9a-f]{64}$').hasMatch(id)) {
      throw const ApiException.notFound('Fichier introuvable.');
    }
    final row = await _db.run(
      (s) =>
          s.queryOne('SELECT mime_type FROM files WHERE id = @id', {'id': id}),
    );
    final file = _fileFor(id);
    if (row == null || !file.existsSync()) {
      throw const ApiException.notFound('Fichier introuvable.');
    }
    return (file: file, mimeType: row['mime_type'] as String?);
  }
}

final class _DigestSink implements Sink<Digest> {
  late Digest value;

  @override
  void add(Digest data) => value = data;

  @override
  void close() {}
}
