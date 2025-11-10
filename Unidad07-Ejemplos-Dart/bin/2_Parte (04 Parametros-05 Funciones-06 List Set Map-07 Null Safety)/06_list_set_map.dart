void main() {
  // Declara una lista de String con tres elementos iniciales.
  // 'final' impide reasignar la variable 'frutas', pero sí permite modificar la lista internamente (add, remove, etc.).
  final frutas = ["Manzana", "Pera", "Plátano"];

  // Agrega un nuevo elemento al final de la lista: ahora hay 4 frutas.
  frutas.add("Uva");

  // Imprime la lista completa y, además, el primer elemento usando la propiedad 'first'.
  // La interpolación ${...} evalúa la expresión y la inserta en el string.
  print("Frutas: $frutas | primera: ${frutas.first}");

  // 'map' recorre cada elemento y devuelve un Iterable con el resultado de aplicar la función.
  // Aquí convertimos cada fruta a mayúsculas. toList() convierte el Iterable en una nueva List<String>.
  final mayus = frutas.map((f) => f.toUpperCase()).toList();

  // 'where' filtra elementos según un predicado booleano.
  // Nos quedamos con las frutas cuyo nombre empieza por "P". toList() para materializar el resultado.
  final empiezanP = frutas.where((f) => f.startsWith("P")).toList();

  // 'fold' acumula un valor: parte de un valor inicial (0) y aplica una función que acumula sobre cada elemento.
  // Especificamos <int> para el tipo del acumulador. Sumamos la longitud de cada nombre de fruta.
  final totalLetras = frutas.fold<int>(0, (acc, f) => acc + f.length);

  /* Si frutas = ["Manzana", "Pera", "Plátano", "Uva"]:

      Inicio: acc = 0

      1ª vuelta (f = "Manzana", length = 7) → acc = 0 + 7 = 7

      2ª vuelta (f = "Pera", length = 4) → acc = 7 + 4 = 11

      3ª vuelta (f = "Plátano", length = 7) → acc = 11 + 7 = 18

      4ª vuelta (f = "Uva", length = 3) → acc = 18 + 3 = 21

    Resultado final: totalLetras = 21.*/


  // Muestra la lista en mayúsculas, la lista filtrada y el total de letras calculado con fold.
  print("Mayus: $mayus | empiezanP: $empiezanP | totalLetras: $totalLetras");

  // Declara un Set<int>. Los sets no permiten duplicados, por eso el segundo '3' se descarta automáticamente.
  final numeros = {1, 2, 3, 3};

  // Imprime el set (verás que solo aparece un '3').
  print("Set sin duplicados: $numeros");

  /*Operaciones útiles con Set*/
  numeros.add(4);        // {1, 2, 3, 4}
  numeros.contains(2);   // true
  numeros.remove(1);     // {2, 3, 4}

  final a = {1, 2, 3};
  final b = {3, 4};
  final unio = a.union(b);           // {1, 2, 3, 4}
  final inter = a.intersection(b);    // {3}
  final diff = a.difference(b);       // {1, 2}

  // Declara un Map<String, Object> con dos entradas (clave 'nombre' y 'edad').
  // En Dart, los mapas asocian claves a valores (tipo diccionario).
  final persona = {"nombre": "Ana", "edad": 30};

  // Modifica el valor de la clave 'edad' asignándole 31. (Actualización in-place del mapa.)
  persona["edad"] = 31;

  // Imprime el mapa completo ya actualizado.
  print("Map persona: $persona");
}

