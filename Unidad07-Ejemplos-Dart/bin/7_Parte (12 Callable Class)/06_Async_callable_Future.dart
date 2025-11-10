// 6) Callable asíncrono: `call` devuelve Future<T>
import 'dart:async';

class SimuladorDescarga {
  Future<String> call(String recurso) async {
    // Simula latencia de red
    await Future.delayed(Duration(milliseconds: 150));
    return 'contenido:$recurso';
  }
}

Future<void> main() async {
  final dl = SimuladorDescarga();
  final dato = await dl('foto.png'); // await a un "callable"
  print(dato);
}
