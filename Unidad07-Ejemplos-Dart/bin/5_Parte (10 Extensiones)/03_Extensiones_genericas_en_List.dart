// 3) Extensiones genéricas en List<T>
//    - Métodos útiles que funcionan con diferentes tipos de listas.
//    - `firstOrNull`, `chunked`, y sumas numéricas cuando T es num.

extension ListBasics<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : this.first;

  List<List<T>> chunked(int size) {
    if (size <= 0) {
      throw ArgumentError("size debe ser > 0");
    }
    final out = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      final end = (i + size < length) ? (i + size) : length;
      out.add(sublist(i, end));
    }
    return out;
  }
}

extension NumListOps<T extends num> on List<T> {
  double sumAsDouble() {
    return fold(0.0, (acc, e) => acc + e.toDouble());
  }

  double average() {
    if (isEmpty) return 0.0;
    return sumAsDouble() / length;
  }
}

void main() {
  final xs = <int>[1, 2, 3, 4, 5];

  print(xs.firstOrNull);        // 1
  print(<int>[].firstOrNull);   // null

  print(xs.chunked(2));         // [[1,2],[3,4],[5]]

  print(xs.sumAsDouble());      // 15.0
  print(xs.average());          // 3.0
}
