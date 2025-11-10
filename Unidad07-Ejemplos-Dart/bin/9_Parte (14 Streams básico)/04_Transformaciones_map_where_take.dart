// 4) Transformaciones: map, where, take, asyncMap, asyncExpand
import 'dart:async';

Stream<int> fuente() async* {
  for (var i = 1; i <= 5; i++) {
    await Future.delayed(Duration(milliseconds: 80));
    yield i;
  }
}

Future<String> fetchDato(int x) async {
  await Future.delayed(Duration(milliseconds: 60));
  return 'D$x';
}

Future<void> main() async {
  final s = fuente()
      .where((x) => x.isOdd)             // 1,3,5
      .map((x) => x * 10)                // 10,30,50
      .asyncMap(fetchDato)               // 'D10','D30','D50'
      .asyncExpand((d) async* {          // duplica eventos
        yield d;
        yield d.toLowerCase();
      })
      .take(5);                          // tomar los primeros 5 eventos

  await for (final e in s) {
    print('e: $e');
  }
}
