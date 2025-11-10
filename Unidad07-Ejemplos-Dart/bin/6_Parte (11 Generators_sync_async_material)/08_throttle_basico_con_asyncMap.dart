// 8) Throttle básico con asyncMap (control simple de ritmo)
//    - Fuente produce eventos rápidos; consumidor limita el ritmo de procesamiento.
import 'dart:async';

Stream<int> rapido(int n) async* {
  for (var i = 1; i <= n; i++) {
    // Emite MUY rápido (sin delay) para simular "backpressure" potencial.
    yield i;
  }
}

Future<T> throttle<T>(T value, Duration pausa) async {
  // Simula trabajo mínimo + espera fija para no procesar demasiado rápido.
  await Future.delayed(pausa);
  return value;
}

Future<void> main() async {
  final procesado = rapido(8)
      .asyncMap((v) => throttle(v, Duration(milliseconds: 120)));

  final sw = Stopwatch()..start();
  await for (final v in procesado) {
    print('[+${sw.elapsedMilliseconds}ms] procesado: $v');
  }
}
