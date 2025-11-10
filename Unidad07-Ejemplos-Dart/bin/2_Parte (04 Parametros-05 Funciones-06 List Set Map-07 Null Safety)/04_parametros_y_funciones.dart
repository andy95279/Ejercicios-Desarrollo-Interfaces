// Define una función con:
// - 1 parámetro posicional obligatorio: 'texto' (String)
// - 1 parámetro posicional opcional entre corchetes []: 'veces' (int) con valor por defecto 1
void mostrar(String texto, [int veces = 1]) {
  // Bucle for: i empieza en 0; se repite mientras i < veces; tras cada iteración i++
  for (var i = 0; i < veces; i++) 
    // Instrucción de una sola línea: imprime el texto en consola
    print(texto);
}

// Función con parámetros con nombre entre llaves {}.
// - 'nombre' es requerido (required)
// - 'edad' es opcional con valor por defecto 18
void crearUsuario({required String nombre, int edad = 18}) {
  // Interpolación de strings: inserta variables dentro del texto usando $variable
  print("Usuario: $nombre, edad: $edad");
}

// Función con mezcla de parámetros:
// - 'id' es posicional obligatorio
// - 'nombre' es con nombre y puede ser null (String?)
// - 'edad' es con nombre con valor por defecto 0
void registrar(String id, {String? nombre, int edad = 0}) {
  // Imprime los valores recibidos (si 'nombre' es null, se imprimirá 'null')
  print("ID: $id, nombre: $nombre, edad: $edad");
}

// Función flecha (arrow function): sintaxis compacta para devolver 'x * x'
int cuadrado(int x) => x * x;

void main() {
  // Llama a 'mostrar' pasando solo el obligatorio: imprime "Hola" 1 vez (veces=1 por defecto)
  mostrar("Hola");

  // Llama a 'mostrar' pasando también el opcional: imprime "Hola" 3 veces
  mostrar("Hola", 3);

  // Llama a 'crearUsuario' usando parámetro con nombre 'nombre'
  crearUsuario(nombre: "Ana");

  // Llama a 'crearUsuario' indicando ambos parámetros con nombre
  crearUsuario(nombre: "Luis", edad: 25);

  // Llama a 'registrar' con:
  // - 'id' posicional
  // - 'nombre' con nombre (edad usará el valor por defecto 0)
  registrar("123", nombre: "Pedro");
  // id="123", nombre=null (no pasado), edad=0 (por defecto)
  registrar("123");
  // id="123", nombre="Ana", edad=0
  registrar("123", nombre: "Ana");
 // id="123", nombre=null, edad=21
  registrar("123", edad: 21);
 // id="123", nombre="Ana", edad=21
  registrar("123", nombre: "Ana", edad: 21);
 // el orden de los con nombre da igual
  registrar("123", edad: 21, nombre: "Ana"); 

  // Llama a 'cuadrado(5)' y muestra el resultado usando interpolación ${...}
  print("5^2 = ${cuadrado(5)}");
}
