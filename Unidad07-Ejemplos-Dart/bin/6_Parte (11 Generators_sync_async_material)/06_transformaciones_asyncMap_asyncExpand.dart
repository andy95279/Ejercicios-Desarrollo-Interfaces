// 6) Transformaciones de Streams: map/where/asyncMap/asyncExpand
import 'dart:async';

Stream<int> fuente() async* {
  for (var i = 1; i <= 5; i++) {
    await Future.delayed(Duration(milliseconds: 100));
    yield i;
  }
}

Future<String> fetchDato(int i) async {
  // Simula un trabajo asíncrono por elemento.
  await Future.delayed(Duration(milliseconds: 120));
  return 'D$i';
}

Future<void> main() async {
  final s = fuente()
      .where((x) => x.isOdd)              // 1,3,5
      .map((x) => x * 10)                 // 10,30,50
      .asyncMap(fetchDato)                // 'D10','D30','D50' (orden preservado)
      .asyncExpand((d) async* {           // por cada elemento, emite dos eventos
        yield d;
        yield d.toLowerCase();
      });

  await for (final e in s) {
    print('evento: $e');
  }
}
