void main() {
  // Variables y tipos básicos
  var nombre = "Ana";      // Inferido: String
  int edad = 30;           // Entero
  double precio = 9.99;    // Decimal
  bool activo = true;      // Booleano

  // final vs const
  final ahora = DateTime.now(); // fijo tras asignarse (ejecución)
  const pi = 3.1416;            // constante de compilación

  print("Hola $nombre, edad: $edad, precio: $precio, activo: $activo");
  print("final ahora: $ahora | const pi: $pi");
}
