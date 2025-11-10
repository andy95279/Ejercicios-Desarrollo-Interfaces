// 6) Orden de mixins y encadenado con 'super'
//    - El último mixin en la lista es el que "gana" si hay mismo método.
//    - Un mixin puede llamar a 'super' para encadenar el comportamiento
//      del mixin anterior (o de la clase base) SI el método existe.

abstract class Etiquetable {
  String etiqueta() => 'Base';
}

mixin M1 on Etiquetable {
  @override
  String etiqueta() => 'M1';
}

mixin M2 on Etiquetable {
  @override
  String etiqueta() => 'M2->' + super.etiqueta(); // Llama al 'etiqueta' previo en la cadena.
}

class Demo extends Etiquetable with M1, M2 {}

void main() {
  final d = Demo();
  print(d.etiqueta()); // "M2->M1"
}
