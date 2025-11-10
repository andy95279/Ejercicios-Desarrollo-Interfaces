// 1) Future básico + then/catchError
import 'dart:async';

Future<String> tareaRapida() async {
  // Simula trabajo asíncrono
  await Future.delayed(Duration(milliseconds: 150));
  return "OK";
}

void main() {
  print("Inicio");
  tareaRapida()
      .then((valor) => print("Resultado: $valor"))
      .catchError((e) => print("Error: $e"))
      .whenComplete(() => print("Completado (con o sin error)"));
  print("Fin inmediato (no bloquea)");
}
