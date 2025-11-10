// 3) Creación: fromIterable y periodic
import 'dart:async';

void main() async {
  print('fromIterable:');
  await for (final v in Stream.fromIterable([10, 20, 30])) {
    print(v);
  }

  print('\nperiodic (3 ticks cada 100ms):');
  // Stream.periodic emite indefinidamente; usamos take(3).
  final periodic = Stream.periodic(Duration(milliseconds: 100), (i) => i + 1).take(3);
  await for (final t in periodic) {
    print('tick $t');
  }
}
