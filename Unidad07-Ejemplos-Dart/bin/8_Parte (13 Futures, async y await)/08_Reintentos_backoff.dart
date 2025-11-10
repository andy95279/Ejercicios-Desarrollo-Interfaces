// 8) Reintentos con backoff exponencial
import 'dart:async';

Future<T> retry<T>(Future<T> Function() op,
    {int intentos = 3, Duration base = const Duration(milliseconds: 100)}) async {
  int intento = 0;
  while (true) {
    intento++;
    try {
      return await op();
    } catch (e) {
      if (intento >= intentos) rethrow;
      final espera = base * (1 << (intento - 1)); // 100ms, 200ms, 400ms, ...
      await Future.delayed(espera);
    }
  }
}

int _contador = 0;
Future<String> recursoInestable() async {
  await Future.delayed(Duration(milliseconds: 80));
  _contador++;
  if (_contador < 3) throw StateError("Fallo intento $_contador");
  return "OK intento $_contador";
}

Future<void> main() async {
  final res = await retry(recursoInestable, intentos: 5);
  print(res);
}
