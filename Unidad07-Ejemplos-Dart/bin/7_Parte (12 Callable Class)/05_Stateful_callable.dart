// 5) Stateful callable: objeto función que recuerda estado (acumulador).
//    - Alternativa a un closure cuando se desea tipo nominal y testabilidad.

class Acumulador {
  num _total = 0;
  num call(num x) {
    _total += x;
    return _total;
  }

  num get total => _total;
  void reset() => _total = 0;
}

void main() {
  final acc = Acumulador();
  print(acc(5));   // 5
  print(acc(2.5)); // 7.5
  print(acc.total); // 7.5
  acc.reset();
  print(acc(1));   // 1
}
