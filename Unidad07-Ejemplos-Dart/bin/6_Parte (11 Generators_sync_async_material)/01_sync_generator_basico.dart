// 1) Generador síncrono básico (sync* + yield)
//    - Produce una secuencia bajo demanda (Iterable<T>).
Iterable<int> rango(int inicio, int finIncluido) sync* {
  for (var x = inicio; x <= finIncluido; x++) {
    yield x; // Emite el siguiente valor cuando el consumidor lo pide.
  }
}

Iterable<int> paresHasta(int n) sync* {
  for (var x = 0; x <= n; x += 2) {
    yield x;
  }
}

void main() {
  print('Rango 3..7: ${rango(3, 7).toList()}');
  print('Pares hasta 10: ${paresHasta(10).toList()}');
}
