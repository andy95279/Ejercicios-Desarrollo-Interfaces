// 4) Funciones de orden superior: usar clases callable donde se espera una función.
//    - `Incrementar` implementa la firma `int Function(int)`.
//    - Lo pasamos a `map`, a una función que recibe 'operador', etc.

typedef IntOp = int Function(int);

class Incrementar {
  int step;
  Incrementar([this.step = 1]);
  int call(int x) => x + step;
}

int aplicar(IntOp op, int x) => op(x); // recibe cualquier "algo" que cumpla la firma

void main() {
  final inc = Incrementar(2);

  // 1) Pasar al map como si fuera función
  final data = [1, 2, 3].map(inc).toList();
  print(data); // [3, 4, 5]

  // 2) Pasar a una función de orden superior
  print(aplicar(inc, 10)); // 12

  // 3) Tear-off explícito (equivalente)
  print(aplicar(inc.call, 5)); // 7
}
