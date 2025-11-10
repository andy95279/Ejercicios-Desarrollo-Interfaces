void main() {
  // Declara una variable 'sumar' y le asigna una función anónima (lambda)
  // que recibe dos enteros (a, b) y devuelve su suma con sintaxis flecha.
  var sumar = (int a, int b) => a + b;

  // Llama a la función anónima almacenada en 'sumar' con 3 y 4.
  // Usa interpolación de strings para mostrar el resultado.
  print("3 + 4 = ${sumar(3,4)}");

  // Declara una función local 'contador' que, al ser invocada,
  // devuelve OTRA función (un "closure") que recuerda el estado de 'cuenta'.
  Function contador() {
    // Variable local capturada por el closure; actúa como estado privado.
    int cuenta = 0;

    // Devuelve una función anónima sin parámetros.
    // Cada vez que se ejecute, incrementará 'cuenta' y la imprimirá.
    return () {
      cuenta++; // incrementa el estado cerrado sobre 'cuenta'
      print("contador: $cuenta");
    };
  }

  // Invoca 'contador()' y obtiene un closure que mantiene su propio 'cuenta'.
  final c = contador();

  // Ejecuta el closure por primera vez: imprime "contador: 1".
  c(); // 1

  // Vuelve a ejecutarlo: el estado persiste, imprime "contador: 2".
  c(); // 2
}
