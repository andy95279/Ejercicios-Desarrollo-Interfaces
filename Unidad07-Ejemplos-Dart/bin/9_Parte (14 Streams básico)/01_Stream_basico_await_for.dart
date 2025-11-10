// 1) Stream básico: producir y consumir con `await for` y `listen`.
import 'dart:async';

Stream<int> contador(int hasta, {Duration pausa = const Duration(milliseconds: 120)}) async* {
  for (var i = 1; i <= hasta; i++) {
    await Future.delayed(pausa);
    yield i;
  }
}

Future<void> main() async {
  print('Consumiendo con await for:');
  await for (final v in contador(5)) {
    print('valor: $v');
  }

  print('\nConsumiendo con listen:');
  final sub = contador(3).listen((v) => print('listen -> $v'));
  await sub.asFuture<void>();
}
