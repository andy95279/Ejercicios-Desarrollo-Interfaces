// 2) Polimorfismo y override
//    - Lista de tipo base (Animal) con Perro y Gato.
//    - Llamada dinámica al método sobrescrito.

abstract class Animal {
  final String nombre;
  Animal(this.nombre);
  void hacerSonido();                       // Método abstracto.
}

class Perro extends Animal {
  Perro(String nombre) : super(nombre);
  @override
  void hacerSonido() => print('$nombre: Guau');
}

class Gato extends Animal {
  Gato(String nombre) : super(nombre);
  @override
  void hacerSonido() => print('$nombre: Miau');
}

void alimentar(Animal a) {
  print('Alimentando a ${a.nombre}...');
  a.hacerSonido(); // Polimorfismo: ejecuta el override concreto.
}

void main() {
  final animales = <Animal>[Perro('Fido'), Gato('Misu')];

  for (final a in animales) {
    a.hacerSonido();
  }

  alimentar(animales.first);
}
