// 1) Clase simple
//    - Campos mutables, constructor abreviado, método de instancia y toString().
//    - Demuestra cómo crear objetos y definir comportamiento.

class Persona {
  String nombre;                        // Campo de instancia: nombre.
  int edad;                             // Campo de instancia: edad.

  Persona(this.nombre, this.edad);      // Constructor abreviado: asigna parámetros a campos usando 'this'.

  void saludar() =>                      // Método de instancia: comportamiento asociado al objeto.
      print("Hola, soy $nombre y tengo $edad años");

  @override
  String toString() =>                   // toString(): representación legible del objeto.
      "Persona(nombre: $nombre, edad: $edad)";
}

void main() {
  // Uso de la clase Persona
  final p1 = Persona("Ana", 25);
  p1.saludar();                         // -> Hola, soy Ana y tengo 25 años
  print(p1);                            // -> Persona(nombre: Ana, edad: 25)

  // Otra instancia
  final p2 = Persona("Luis", 17);
  p2.saludar();
  print(p2);
}
