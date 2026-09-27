// Régénère lib/src/pdf_assets.g.dart à partir du dossier assets/
// (polices Liberation Sans — licence SIL OFL 1.1 — et profil sRGB) :
//   dart run tool/embed_assets.dart
import 'dart:convert';
import 'dart:io';

void main() {
  final out = StringBuffer()
    ..writeln('// Généré par tool/embed_assets.dart — ne pas modifier.')
    ..writeln('// Polices : Liberation Sans (SIL Open Font License 1.1,')
    ..writeln('// assets/LiberationSans-LICENSE.txt). Contenu compressé (gzip).')
    ..writeln('// ignore_for_file: lines_longer_than_80_chars')
    ..writeln();
  for (final (name, file) in [
    ('regularFontGz', 'LiberationSans-Regular.ttf'),
    ('boldFontGz', 'LiberationSans-Bold.ttf'),
    ('srgbIccGz', 'sRGB2014.icc'),
  ]) {
    final bytes = gzip.encode(File('assets/$file').readAsBytesSync());
    out.writeln("const $name = '${base64.encode(bytes)}';");
  }
  File('lib/src/pdf_assets.g.dart').writeAsStringSync(out.toString());
}
