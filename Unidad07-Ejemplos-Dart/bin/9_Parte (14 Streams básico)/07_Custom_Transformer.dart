// 7) StreamTransformer personalizado: convertir int -> String con formato
import 'dart:async';

class FormatoTransformer extends StreamTransformerBase<int, String> {
  @override
  Stream<String> bind(Stream<int> stream) async* {
    await for (final v in stream) {
      yield 'N[$v]'; // envuelve cada entero con un prefijo
    }
  }
}

Stream<int> fuente() async* {
  for (var i = 1; i <= 3; i++) {
    await Future.delayed(Duration(milliseconds: 80));
    yield i;
  }
}

Future<void> main() async {
  final formateado = fuente().transform(FormatoTransformer());
  await for (final s in formateado) {
    print(s); // N[1], N[2], N[3]
  }
}
