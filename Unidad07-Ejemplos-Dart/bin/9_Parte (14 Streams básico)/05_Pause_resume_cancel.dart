// 5) Control de suscripción: pause, resume, cancel
import 'dart:async';

Stream<int> contadorRapido(int n) async* {
  for (var i = 1; i <= n; i++) {
    await Future.delayed(Duration(milliseconds: 80));
    yield i;
  }
}

Future<void> main() async {
  final sub = contadorRapido(10).listen((v) => print('dato: $v'));
  // Pausar a los 250ms y reanudar a los 600ms
  Future.delayed(Duration(milliseconds: 250), () {
    print('--- pausa ---');
    sub.pause();
  });
  Future.delayed(Duration(milliseconds: 600), () {
    print('--- resume ---');
    sub.resume();
  });
  // Cancelar antes de que termine
  Future.delayed(Duration(milliseconds: 900), () {
    print('--- cancel ---');
    sub.cancel();
  });

  await Future.delayed(Duration(seconds: 2)); // esperar para ver el efecto
}
