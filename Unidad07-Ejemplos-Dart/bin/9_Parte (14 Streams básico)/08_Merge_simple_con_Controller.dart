// 8) Merge simple de dos streams (sin librerías externas)
import 'dart:async';

Stream<T> merge<T>(Stream<T> a, Stream<T> b) {
  final controller = StreamController<T>();
  late final StreamSubscription<T> sa;
  late final StreamSubscription<T> sb;
  var activos = 2;

  void onDone() {
    activos--;
    if (activos == 0) controller.close();
  }

  // Reemitimos eventos de 'a' y 'b' hacia el controller
  sa = a.listen(
    controller.add,
    onError: controller.addError,
    onDone: onDone,
    cancelOnError: false,
  );

  sb = b.listen(
    controller.add,
    onError: controller.addError,
    onDone: onDone,
    cancelOnError: false,
  );

  // Si alguien cancela el stream resultante, cancelamos ambas suscripciones
  controller.onCancel = () async {
    await sa.cancel();
    await sb.cancel();
  };

  return controller.stream;
}

Stream<int> s1() async* {
  for (var i = 1; i <= 3; i++) {
    await Future.delayed(Duration(milliseconds: 90));
    yield i * 10; // 10,20,30
  }
}

Stream<int> s2() async* {
  for (var i = 1; i <= 3; i++) {
    await Future.delayed(Duration(milliseconds: 60));
    yield i; // 1,2,3
  }
}

Future<void> main() async {
  final m = merge(s1(), s2());
  await for (final v in m) {
    print('merge -> $v');
  }
}
