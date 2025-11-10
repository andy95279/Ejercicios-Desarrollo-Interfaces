// 2) async/await básico
import 'dart:async';

Future<int> cuadradoAsync(int x) async {
  await Future.delayed(Duration(milliseconds: 120));
  return x * x;
}

Future<void> main() async {
  print("Calculando...");
  final a = await cuadradoAsync(3);
  final b = await cuadradoAsync(4);
  print("Resultados: a=$a, b=$b"); // a=9, b=16
}
