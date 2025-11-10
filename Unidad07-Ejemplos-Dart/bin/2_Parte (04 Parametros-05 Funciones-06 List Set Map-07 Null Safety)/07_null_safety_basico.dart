void main() {
  // Declara una variable de tipo String anulable (puede ser null) y no le asigna valor => vale null.
  String? nombre; // anulable

  // Usa el operador de fusión nula '??' para proporcionar un valor por defecto si 'nombre' es null.
  // Luego aplica toUpperCase() al resultado (seguro porque ya no es null).
  print((nombre ?? "Desconocido").toUpperCase());

  // Declara otra variable anulable y le asigna "Hola" (no es null ahora mismo).
  String? texto = "Hola";

  // Usa el operador '!' (null assertion / bang operator) para decirle al compilador:
  // "confío en que 'texto' NO es null aquí". Accede a length.
  // ¡Cuidado!: si 'texto' fuera null en tiempo de ejecución, lanzaría una excepción.
  print("length con !: ${texto.length}"); // cuidado si fuese null

  // Declara una variable no anulable que se inicializará más tarde.
  // 'late' permite diferir la asignación, pero te comprometes a inicializarla antes de usarla.
  late String apellido;

  // Inicializa la variable 'apellido' antes de su primer uso.
  apellido = "García";

  // Ya se puede usar con normalidad: no es null.
  print("apellido: $apellido");
}

