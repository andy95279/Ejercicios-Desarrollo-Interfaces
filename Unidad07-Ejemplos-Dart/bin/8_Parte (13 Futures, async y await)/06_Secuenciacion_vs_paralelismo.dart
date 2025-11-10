// 6) Secuenciación vs paralelismo (medición simple)
import 'dart:async';

Future<int> trabajo(int ms) async {
  await Future.delayed(Duration(milliseconds: ms));
  return ms;
}

Future<void> main() async {
  // Secuencial (await uno por uno)
  final t1 = Stopwatch()..start();
  final a = await trabajo(200);
  final b = await trabajo(250);
  final c = await trabajo(150);
  t1.stop();
  print("Secuencial: ${t1.elapsedMilliseconds} ms -> [$a, $b, $c]");

  // Paralelo (lanzar y luego esperar a todos)
  final t2 = Stopwatch()..start();
  final fA = trabajo(200);
  final fB = trabajo(250);
  final fC = trabajo(150);
  final res = await Future.wait([fA, fB, fC]);
  t2.stop();
  print("Paralelo: ${t2.elapsedMilliseconds} ms -> $res");
}
