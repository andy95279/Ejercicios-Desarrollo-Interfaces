// 4) Mixins básicos
//    - Reutilizar comportamiento con 'with' (sin herencia múltiple).
//    - Un mixin NO tiene constructor y aporta métodos/propiedades.

class Animal {
  final String nombre;
  Animal(this.nombre);
}

mixin Volador {
  void volar() => print('Estoy volando');
}

mixin Nadador {
  void nadar() => print('Estoy nadando');
}

class Pato extends Animal with Volador, Nadador {
  Pato(String nombre) : super(nombre);
  void presentarse() => print('Soy $nombre, un pato que vuela y nada.');
}

void main() {
  final p = Pato('Donald');
  p.presentarse();
  p.volar();   // del mixin Volador
  p.nadar();   // del mixin Nadador
}
