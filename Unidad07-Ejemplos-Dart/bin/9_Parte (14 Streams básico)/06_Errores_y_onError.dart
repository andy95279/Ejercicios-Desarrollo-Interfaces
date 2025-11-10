// 6) Errores en streams: addError, onError, try/catch con await for
import 'dart:async';

Stream<int> conErrores() async* {
  yield 1;
  yield 2;
  throw StateError('fallo!');
}

Future<void> main() async {
  // a) await for + try/catch
  try {
    await for (final v in conErrores()) {
      print('v=$v');
    }
  } catch (e) {
    print('capturado await for: $e');
  }

  // b) listen + onError
  final sub = conErrores().listen(
    (v) => print('listen v=$v'),
    onError: (e, st) => print('listen error: $e'),
    onDone: () => print('listen done'),
  );
  await sub.asFuture<void>().catchError((_) {});
}
