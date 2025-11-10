// 7) Comparativa: closure vs clase callable
//    - Ambos pueden mantener estado; la clase aporta un "tipo" y métodos auxiliares.

// Closure con estado
Function crearSumadorClosure([int inicio = 0]) {
  int total = inicio;
  return (int x) {
    total += x;
    return total;
  };
}

// Clase callable equivalente
class Sumador {
  int _total;
  Sumador([this._total = 0]);
  int call(int x) => _total += x;
  void reset() => _total = 0;
  int get total => _total;
}

void main() {
  // Closure
  final c = crearSumadorClosure(10);
  print(c(5)); // 15
  print(c(2)); // 17

  // Clase callable
  final s = Sumador(10);
  print(s(5)); // 15
  print(s(2)); // 17
  s.reset();
  print(s.total); // 0
}
