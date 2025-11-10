// 2) Extensiones en int
//    - Añadimos utilidades como `isPrime` y `times` (repite una acción N veces).

extension IntUtils on int {
  bool get isPrime {
    final n = this;
    if (n < 2) return false;
    if (n % 2 == 0) return n == 2;
    var d = 3;
    while (d * d <= n) {
      if (n % d == 0) return false;
      d += 2;
    }
    return true;
  }

  void times(void Function(int i) f) {
    for (var i = 0; i < this; i++) {
      f(i);
    }
  }
}

void main() {
  print(7.isPrime);  // true
  print(8.isPrime);  // false

  3.times((i) => print("Iteración #$i"));
}
