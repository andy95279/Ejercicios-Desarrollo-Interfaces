// 4) Parallel: Future.wait, Future.any y timeout
import 'dart:async';

Future<String> tarea(String nombre, int ms) async {
  await Future.delayed(Duration(milliseconds: ms));
  return "$nombre(${ms}ms)";
}

Future<void> main() async {
  // a) Ejecutar en paralelo y esperar a todas
  final todas = await Future.wait([
    tarea("A", 200),
    tarea("B", 120),
    tarea("C", 180),
  ]);
  print("Todas -> $todas");

  // b) Esperar a la PRIMERA que termine
  final primera = await Future.any([
    tarea("X", 220),
    tarea("Y", 90),
    tarea("Z", 150),
  ]);
  print("Primera -> $primera");

  // c) timeout: lanza excepción si tarda demasiado
  try {
    final r = await tarea("Lenta", 300).timeout(Duration(milliseconds: 100));
    print("Timeout OK -> $r");
  } on TimeoutException {
    print("Timeout: operación excedió el tiempo");
  }
}
