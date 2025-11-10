// 2) Composición con yield*
//    - yield* delega la emisión de valores a otro Iterable/Stream.
Iterable<int> naturales(int n) sync* {
  for (var i = 1; i <= n; i++) yield i;
}

Iterable<int> cuadradosNaturales(int n) sync* {
  // Reutilizamos 'naturales' y delegamos con yield*.
  yield* naturales(n).map((x) => x * x);
}

// Debe devolver Iterable<T>, no Iterable<int>
Iterable<T> concatenar<T>(Iterable<T> a, Iterable<T> b) sync* {
  yield* a;
  yield* b;
}

void main() {
  print('Cuadrados hasta 5: ${cuadradosNaturales(5).toList()}');

  // Infiere T=int automáticamente
  print('Concat: ${concatenar([1,2], [3,4]).toList()}');

  // Ejemplo con String (muestra que es genérica)
  print('Concat str: ${concatenar(['a','b'], ['c']).toList()}');
}

