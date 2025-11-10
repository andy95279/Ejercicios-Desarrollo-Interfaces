// 9) Reporte de progreso con Stream desde una función async
import 'dart:async';

// Devuelve un Stream<int> con el porcentaje de progreso (0..100).
Stream<int> descargarConProgreso(int pasos, {Duration pausa = const Duration(milliseconds: 80)}) async* {
  for (var i = 0; i <= pasos; i++) {
    await Future.delayed(pausa);
    yield ((i / pasos) * 100).round();
  }
}

Future<void> main() async {
  print("Descargando...");
  await for (final p in descargarConProgreso(10)) {
    print("Progreso: $p%");
  }
  print("Completado.");
}
