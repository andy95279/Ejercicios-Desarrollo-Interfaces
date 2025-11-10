// 5) Mixins con restricciones (`on`)
//    - Restringe el mixin a clases que extiendan/implementen cierto tipo.
//    - Dentro del mixin puedes usar miembros del tipo restringido.

abstract class Animal {
  String get nombre;
  void hacerSonido();
}

mixin Registrable on Animal {
  void logAccion(String accion) {
    print('[LOG] $nombre -> $accion'); // Podemos acceder a 'nombre' por la restricción 'on Animal'.
  }
}

class Perro implements Animal {
  @override
  final String nombre;
  Perro(this.nombre);

  @override
  void hacerSonido() => print('$nombre: Guau');
}

class PerroRegistrado extends Perro with Registrable {
  PerroRegistrado(String nombre) : super(nombre);

  void moverCola() {
    logAccion('mover cola'); // del mixin Registrable
    print('$nombre mueve la cola.');
  }
}

void main() {
  final p = PerroRegistrado('Fido');
  p.hacerSonido();
  p.moverCola();
}
