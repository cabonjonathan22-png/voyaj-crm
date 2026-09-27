import 'package:meta/meta.dart';

/// Horloge logique hybride (Hybrid Logical Clock, Kulkarni et al. 2014).
///
/// Combine l'horloge murale (millisecondes) et un compteur logique : l'ordre
/// reste cohérent avec la causalité même si les horloges des postes sont
/// légèrement décalées. Sert d'arbitre pour le « last-write-wins » par champ.
///
/// Représentation texte triable lexicographiquement :
/// `<millis sur 15 chiffres>:<compteur hex sur 4>:<nœud>`.
@immutable
final class Hlc implements Comparable<Hlc> {
  const Hlc(this.millis, this.counter, this.node)
    : assert(millis >= 0),
      assert(counter >= 0 && counter <= maxCounter);

  /// Horloge initiale d'un nœud.
  const Hlc.zero(this.node) : millis = 0, counter = 0;

  factory Hlc.parse(String value) {
    final first = value.indexOf(':');
    final second = first < 0 ? -1 : value.indexOf(':', first + 1);
    if (first != 15 || second != 20 || second == value.length - 1) {
      throw FormatException('HLC invalide', value);
    }
    final millis = int.tryParse(value.substring(0, first));
    final counter = int.tryParse(value.substring(first + 1, second), radix: 16);
    if (millis == null || counter == null) {
      throw FormatException('HLC invalide', value);
    }
    return Hlc(millis, counter, value.substring(second + 1));
  }

  static const maxCounter = 0xFFFF;

  /// Avance maximale tolérée d'une horloge distante sur l'horloge locale.
  static const maxDrift = Duration(minutes: 1);

  final int millis;
  final int counter;
  final String node;

  /// Horodatage pour un événement local (écriture).
  Hlc send(int nowMillis) {
    if (nowMillis > millis) return Hlc(nowMillis, 0, node);
    return _withCounter(millis, counter + 1);
  }

  /// Fusionne une horloge distante reçue (lecture d'un changement).
  ///
  /// Lève [ClockDriftException] si l'horloge distante est trop en avance.
  Hlc receive(Hlc remote, int nowMillis) {
    if (remote.millis - nowMillis > maxDrift.inMilliseconds) {
      throw ClockDriftException(remote, nowMillis);
    }
    final newMillis = [
      millis,
      remote.millis,
      nowMillis,
    ].reduce((a, b) => a > b ? a : b);
    final int newCounter;
    if (newMillis == millis && newMillis == remote.millis) {
      newCounter = (counter > remote.counter ? counter : remote.counter) + 1;
    } else if (newMillis == millis) {
      newCounter = counter + 1;
    } else if (newMillis == remote.millis) {
      newCounter = remote.counter + 1;
    } else {
      newCounter = 0;
    }
    return _withCounter(newMillis, newCounter);
  }

  Hlc _withCounter(int newMillis, int newCounter) {
    if (newCounter > maxCounter) {
      throw StateError('Dépassement du compteur HLC');
    }
    return Hlc(newMillis, newCounter, node);
  }

  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true);

  @override
  int compareTo(Hlc other) {
    final byMillis = millis.compareTo(other.millis);
    if (byMillis != 0) return byMillis;
    final byCounter = counter.compareTo(other.counter);
    if (byCounter != 0) return byCounter;
    return node.compareTo(other.node);
  }

  bool operator >(Hlc other) => compareTo(other) > 0;
  bool operator <(Hlc other) => compareTo(other) < 0;

  @override
  bool operator ==(Object other) =>
      other is Hlc &&
      other.millis == millis &&
      other.counter == counter &&
      other.node == node;

  @override
  int get hashCode => Object.hash(millis, counter, node);

  @override
  String toString() =>
      '${millis.toString().padLeft(15, '0')}:'
      '${counter.toRadixString(16).padLeft(4, '0')}:$node';
}

/// L'horloge distante est trop en avance : on refuse le changement plutôt
/// que de propager une horloge aberrante à tous les postes.
final class ClockDriftException implements Exception {
  const ClockDriftException(this.remote, this.nowMillis);

  final Hlc remote;
  final int nowMillis;

  @override
  String toString() =>
      'Horloge distante en avance de '
      '${remote.millis - nowMillis} ms (max ${Hlc.maxDrift.inMilliseconds} ms)';
}

/// Horloge HLC mutable d'un nœud (poste client ou serveur).
final class HybridClock {
  HybridClock(String node, {Hlc? last, int Function()? wallClock})
    : _last = last ?? Hlc.zero(node),
      _wallClock = wallClock ?? _systemMillis;

  Hlc _last;
  final int Function() _wallClock;

  static int _systemMillis() => DateTime.now().millisecondsSinceEpoch;

  Hlc get last => _last;

  /// Horodatage d'une écriture locale.
  Hlc now() => _last = _last.send(_wallClock());

  /// Intègre une horloge observée (changement reçu du serveur).
  void observe(Hlc remote) => _last = _last.receive(remote, _wallClock());
}
