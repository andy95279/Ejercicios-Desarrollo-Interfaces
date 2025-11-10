// 5) Consumo de Stream: listen, cancel y control de suscripción
import 'dart:async';

Stream<int> contador(int desde, int hasta, Duration pausa) async* {
  for (var i = desde; i <= hasta; i++) {
    await Future.delayed(pausa);
    yield i;
  }
}

Future<void> main() async {
  final stream = contador(1, 10, Duration(milliseconds: 150));
  final sub = stream.listen(
    (dato) => print('dato: $dato'),
    onDone: () => print('hecho'),
    onError: (e, st) => print('error: $e'),
    cancelOnError: false,
  );

  // Cancelamos después de 600ms (no veremos todos los datos).
  Future.delayed(Duration(milliseconds: 600), () {
    print('Cancelando suscripción...');
    sub.cancel();
  });

  // Espera un poco para que se vea la cancelación antes de que main termine.
  await Future.delayed(Duration(seconds: 1));
}
