// 2) StreamController: single-subscription vs broadcast
import 'dart:async';

Future<void> main() async {
  // a) Single-subscription (por defecto): solo 1 oyente permitido.
  final c1 = StreamController<int>(); // single por defecto
  c1.add(1);
  c1.add(2);
  c1.add(3);
  c1.close();

  print('Single-subscription:');
  await for (final v in c1.stream) {
    print('s1 -> $v');
  }
  // Si intentas escuchar de nuevo, lanzaría StateError.

  // b) Broadcast: múltiples oyentes simultáneos.
  final c2 = StreamController<String>.broadcast();
  final s = c2.stream;

  print('\nBroadcast con 2 oyentes:');
  final subA = s.listen((v) => print('A: $v'));
  final subB = s.listen((v) => print('B: $v'));
  c2.add('hola');
  c2.add('mundo');
  await c2.close();
  await Future.wait([subA.asFuture<void>(), subB.asFuture<void>()]);
}
