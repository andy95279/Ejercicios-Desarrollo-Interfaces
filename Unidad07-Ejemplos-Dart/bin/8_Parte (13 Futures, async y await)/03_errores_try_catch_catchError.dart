// 3) Manejo de errores: try/catch/finally vs catchError
import 'dart:async';

Future<int> fallaSiNegativo(int x) async {
  await Future.delayed(Duration(milliseconds: 80));
  if (x < 0) throw ArgumentError("x no puede ser negativo");
  return x * 2;
}

Future<void> main() async {
  // a) try/catch/finally
  try {
    final r = await fallaSiNegativo(-1);
    print("Resultado: $r");
  } on ArgumentError catch (e) {
    print("ArgumentError capturado: ${e.message}");
  } catch (e) {
    print("Otro error: $e");
  } finally {
    print("Siempre se ejecuta (finally)");
  }

  // b) then/catchError
  await fallaSiNegativo(2)
      .then((v) => print("then -> $v"))
      .catchError((e) => print("catchError -> $e"));
}
