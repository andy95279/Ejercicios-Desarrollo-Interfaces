// 6) Extensiones con restricciones genéricas (T extends num)
//    - Métodos solo disponibles cuando T cumple una restricción.
//    - Ejemplo: normalizar valores numéricos en un rango.

extension NormalizeNumList<T extends num> on List<T> {
  List<double> normalize01() {
    if (isEmpty) return <double>[];
    final doubles = map((e) => e.toDouble()).toList();
    final min = doubles.reduce((a, b) => a < b ? a : b);
    final max = doubles.reduce((a, b) => a > b ? a : b);
    final range = max - min;
    if (range == 0) {
      return List.filled(length, 0.0);
    }
    return doubles.map((v) => (v - min) / range).toList();
  }
}

void main() {
  final datos = <double>[10, 20, 30, 40];
  print(datos.normalize01()); // [0.0, 0.333..., 0.666..., 1.0]

  final enteros = <int>[5, 5, 5];
  print(enteros.normalize01()); // [0.0, 0.0, 0.0]
}
