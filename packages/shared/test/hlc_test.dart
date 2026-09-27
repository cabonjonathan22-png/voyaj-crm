import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

void main() {
  group('Hlc', () {
    test('toString / parse aller-retour avec un nœud contenant des tirets', () {
      const hlc = Hlc(
        1727000000000,
        42,
        '0192a3b4-c5d6-7e8f-9a0b-1c2d3e4f5a6b',
      );
      expect(Hlc.parse(hlc.toString()), hlc);
      expect(hlc.toString(), startsWith('001727000000000:002a:'));
    });

    test('parse rejette les formats invalides', () {
      expect(() => Hlc.parse('abc'), throwsFormatException);
      expect(() => Hlc.parse('001727000000000:002a:'), throwsFormatException);
      expect(() => Hlc.parse('1727000000000:002a:n'), throwsFormatException);
    });

    test("l'ordre du texte suit l'ordre des HLC", () {
      final values = [
        const Hlc(2, 0, 'a'),
        const Hlc(1, 5, 'b'),
        const Hlc(1, 5, 'a'),
        const Hlc(10, 0, 'a'),
      ];
      final byHlc = [...values]..sort();
      final byText = [...values]
        ..sort((x, y) => x.toString().compareTo(y.toString()));
      expect(byText, byHlc);
    });

    test('send est strictement croissant même si l’horloge recule', () {
      var clock = const Hlc.zero('n');
      clock = clock.send(1000);
      final a = clock;
      clock = clock.send(900); // horloge murale qui recule
      expect(clock > a, isTrue);
      expect(clock.millis, 1000);
      expect(clock.counter, 1);
      clock = clock.send(2000);
      expect(clock, const Hlc(2000, 0, 'n'));
    });

    test('receive dépasse l’horloge distante et locale', () {
      const local = Hlc(1000, 3, 'a');
      const remote = Hlc(1000, 7, 'b');
      final merged = local.receive(remote, 500);
      expect(merged, const Hlc(1000, 8, 'a'));
      expect(merged > remote, isTrue);

      final ahead = local.receive(const Hlc(1500, 2, 'b'), 1200);
      expect(ahead, const Hlc(1500, 3, 'a'));

      final wall = local.receive(const Hlc(900, 9, 'b'), 5000);
      expect(wall, const Hlc(5000, 0, 'a'));
    });

    test('receive refuse une horloge distante trop en avance', () {
      const local = Hlc(0, 0, 'a');
      final future = Hlc(1000 + Hlc.maxDrift.inMilliseconds + 1, 0, 'b');
      expect(
        () => local.receive(future, 1000),
        throwsA(isA<ClockDriftException>()),
      );
    });

    test('dépassement du compteur', () {
      const clock = Hlc(1000, Hlc.maxCounter, 'a');
      expect(() => clock.send(1000), throwsStateError);
    });
  });

  group('HybridClock', () {
    test('now() et observe()', () {
      var wall = 100;
      final clock = HybridClock('n', wallClock: () => wall);
      final first = clock.now();
      expect(first, const Hlc(100, 0, 'n'));
      clock.observe(const Hlc(200, 4, 'm'));
      expect(clock.last, const Hlc(200, 5, 'n'));
      wall = 300;
      expect(clock.now(), const Hlc(300, 0, 'n'));
    });
  });
}
