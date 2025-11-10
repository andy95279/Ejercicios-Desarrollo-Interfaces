// 3) Genéricos: callable T -> R
//    - `Mapper<T, R>` envuelve una transformación genérica y la expone vía `call`.

class Mapper<T, R> {
  final R Function(T) _fn;
  Mapper(this._fn);

  R call(T input) => _fn(input);
}

void main() {
  final toLen = Mapper<String, int>((s) => s.length);
  final doubleIt = Mapper<int, int>((x) => x * 2);

  print(toLen('hola'));   // 4
  print(doubleIt(7));     // 14

  // Se puede usar con colecciones:
  final xs = ['uno', 'dos', 'tres'].map(toLen).toList();
  print(xs); // [3, 3, 4]
}
