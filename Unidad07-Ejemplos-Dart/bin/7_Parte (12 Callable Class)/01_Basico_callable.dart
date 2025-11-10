// 1) Básico: una clase es "callable" si define `call(...)`.
//    - Instancias se usan como si fueran funciones.

class Sumar {
  int call(int a, int b) => a + b; // define la "invocación" del objeto
}

void main() {
  final sumar = Sumar();
  // Uso como si fuera una función
  print(sumar(3, 4)); // 7
  // También se puede invocar explícitamente: sumar.call(3,4)
}
