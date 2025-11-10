// 7) Manejo de errores con Streams
import 'dart:async';

Stream<int> conErrores() async* {
  yield 1;
  yield 2;
  // Emite un error en mitad del stream.
  throw StateError('fallo intermedio');
  // (No se ejecuta) yield 3;
}

Future<void> main() async {
  // a) Manejo con await for + try/catch
  try {
    await for (final v in conErrores()) {
      print('valor: $v');
    }
  } catch (e) {
    print('Capturado con try/catch: $e');
  }

  // b) Manejo con listen(onError: ...)
  final sub = conErrores().listen(
    (v) => print('listen valor: $v'),
    onError: (e, st) => print('listen error: $e'),
    onDone: () => print('listen done'),
  );
  await sub.asFuture<void>().catchError((_) {}); // suprime propagación
}
