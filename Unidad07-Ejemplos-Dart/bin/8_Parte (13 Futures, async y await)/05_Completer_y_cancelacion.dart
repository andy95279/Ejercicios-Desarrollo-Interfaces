// 5) Completer y cancelación cooperativa
import 'dart:async';

class CancelToken {
  bool _cancelado = false;
  void cancel() => _cancelado = true;
  bool get isCanceled => _cancelado;
}

// Función que respeta un token de cancelación (cooperativa).
Future<int> contarLento(int hasta, CancelToken token) async {
  var c = 0;
  while (c < hasta) {
    if (token.isCanceled) throw StateError("Cancelado");
    await Future.delayed(Duration(milliseconds: 60));
    c++;
  }
  return c;
}

// Ejemplo de Completer para exponer un Future que se completa desde fuera.
Future<String> conCompleter() {
  final completer = Completer<String>();
  // Simula completar en el futuro (éxito o error)
  Future.delayed(Duration(milliseconds: 120), () {
    completer.complete("listo");
    // completer.completeError("fallo");
  });
  return completer.future;
}

Future<void> main() async {
  // a) Cancelación cooperativa
  final token = CancelToken();
  final f = contarLento(10, token);
  // Cancelamos a mitad
  Future.delayed(Duration(milliseconds: 210), token.cancel);

  try {
    final n = await f;
    print("Terminó con $n");
  } catch (e) {
    print("capturado: $e");
  }

  // b) Completer
  final v = await conCompleter();
  print("Completer -> $v");
}
