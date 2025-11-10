// 1) Herencia básica
//    - Superclase Animal con un campo y un método.
//    - Subclases Perro y Gato que llaman al constructor de la superclase con super(...).

class Animal {
  final String nombre;                     // Campo común a todos los animales.
  Animal(this.nombre);                     // Constructor de la superclase.

  void hacerSonido() {                     // Método "genérico".
    print('$nombre hace algún sonido.');
  }
}

class Perro extends Animal {
  Perro(String nombre) : super(nombre);    // Llama al constructor de Animal.

  @override
  void hacerSonido() {                     // Sobrescribe el método.
    print('$nombre dice: Guau');
  }
}

class Gato extends Animal {
  Gato(String nombre) : super(nombre);

  @override
  void hacerSonido() {
    print('$nombre dice: Miau');
  }
}

void main() {
  final p = Perro('Fido');
  final g = Gato('Misu');

  p.hacerSonido(); // Guau
  g.hacerSonido(); // Miau
}
