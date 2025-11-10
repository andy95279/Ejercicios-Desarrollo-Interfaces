// 4) Generador asíncrono básico (async* + yield)
//    - Produce un Stream<int> con esperas artificiales.
import 'dart:async';

Stream<int> ticks(int cuantos, Duration pausa) async* {
  for (var i = 1; i <= cuantos; i++) {
    await Future.delayed(pausa); // espera asíncrona
    yield i;                     // emite al stream
  }
}

Future<void> main() async {
  print('Empiezan los ticks...');
  await for (final t in ticks(5, Duration(milliseconds: 200))) {
    print('tick $t');
  }
  print('Fin.');
}
