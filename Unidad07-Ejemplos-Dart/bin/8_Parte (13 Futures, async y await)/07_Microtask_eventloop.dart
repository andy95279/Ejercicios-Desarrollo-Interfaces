// 7) Microtasks y event loop: orden de ejecución
import 'dart:async';

void main() {
  print("A) inicio");

  scheduleMicrotask(() => print("B) microtask 1"));
  Future(() => print("C) future (event) 1")); // cola de eventos
  scheduleMicrotask(() => print("D) microtask 2"));
  Future(() => print("E) future (event) 2"));

  print("F) fin main");
}
// Orden típico:
// A) inicio
// F) fin main
// B) microtask 1
// D) microtask 2
// C) future (event) 1
// E) future (event) 2
