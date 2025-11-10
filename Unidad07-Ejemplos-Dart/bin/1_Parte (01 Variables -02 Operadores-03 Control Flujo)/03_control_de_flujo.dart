// Función principal: punto de entrada del programa.
void main() {
  // Declara una variable de solo lectura (final) con el día actual.
  // 'final' fija la referencia después de esta asignación.
  final dia = "Sábado";

  // Estructura de selección múltiple para tomar acciones según el valor de 'dia'.
  switch (dia) {
    // Cuando 'dia' sea "Lunes", cae al siguiente case (sin break) para agrupar lógica.
    case "Lunes":
    // Cuando 'dia' sea "Martes", ejecuta el mismo bloque que para "Lunes".
    case "Martes":
      // Imprime un mensaje específico para inicio de semana.
      print("Inicio de semana");
      // Termina el 'switch' para estos casos y evita seguir evaluando.
      break;

    // NOTA: Este patrón usa un OR lógico en el 'case'. Requiere Dart 3 (patrones).
    // En versiones anteriores, debes escribir dos 'case' independientes como arriba.
    // Agrupa sábado o domingo como fin de semana.
    case "Sábado" || "Domingo":
      // Imprime un mensaje específico para fin de semana.
      print("Fin de semana");
      // Termina el 'switch' para este caso.
      break;

    // Caso por defecto: se ejecuta si ninguno de los 'case' anteriores coincide.
    default:
      // Imprime un mensaje genérico.
      print("Día normal");
  }

  // Bucle 'for' clásico: inicializa i=0; repite mientras i<3; incrementa i en cada iteración.
  for (var i = 0; i < 3; i++) {
    // Muestra el valor actual de i en cada vuelta del bucle.
    print("for i=$i");
  }

  // Bucle 'for-in': itera directamente sobre cada elemento de la lista dada.
  for (final fruta in ["Manzana", "Pera"]) {
    // Imprime el elemento actual de la iteración (cada fruta).
    print("for-in $fruta");
  }

  // Declara e inicializa un contador para el bucle 'while'.
  var c = 0;

  // Bucle 'while': se ejecuta mientras la condición (c < 2) sea verdadera.
  while (c < 2) {
    // Muestra el valor actual del contador.
    print("while c=$c");
    // Incrementa el contador para avanzar hacia la condición de salida.
    c++;
  }

  //Do ...while
  int n = 0;
  do {
    print('n = $n');
    n++;
  } while (n < 3); // imprime 0, 1, 2

}

