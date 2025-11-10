// Función principal, punto de entrada del programa.
void main() {
  // --- Null-aware ---

  // Declara una variable de tipo String que PUEDE ser nula (nullable).
  // Al no asignarle valor, su valor inicial es null.
  String? nombre;

  // Imprime "Usuario: <valor>". Usa el operador ?? para proporcionar un valor por defecto.
  // Si 'nombre' es null, se imprime "Invitado"; si no es null, se imprime su contenido.
  print("Usuario: ${nombre ?? "Invitado"}");

  // Declara una variable nullable e INICIALIZA con "Hola".
  // Aunque sea String?, ahora mismo NO es null.
  String? texto = "Hola";

  // Accede de forma segura a la propiedad length con el operador ?. (null-aware access).
  // Si 'texto' es null, 'texto?.length' produce null (no lanza error).
  // La interpolación convertirá null en la cadena "null".
  print("Longitud segura: ${texto.length}");

  // --- Cascade operator (..) ---

  // Crea un StringBuffer y encadena varias llamadas sobre la MISMA instancia con el operador ..
  // 1) StringBuffer() crea el objeto.
  // 2) ..write("Hola ") llama a write sobre ese mismo objeto.
  // 3) ..write("Mundo") vuelve a llamar a write sobre la MISMA instancia.
  // Nota: 'final' hace inmutable la referencia, no el contenido del objeto (StringBuffer es mutable).
  final buffer = StringBuffer()
    ..write("Hola ")
    ..write("Mundo");

  // Convierte el contenido acumulado del StringBuffer a String e imprime "Hola Mundo".
  print(buffer.toString());
}

