// 2) Clase inmutable
//    - Uso de 'final' para inmutabilidad y 'const' para instancias en tiempo de compilación.
//    - Constructores nombrados y redirigidos (: this(...)) y 'factory' desde un mapa.
//    - Validación con 'assert' en lista de inicialización.

class Punto {
  final double x;
  final double y;

  const Punto(this.x, this.y)
      // Si x o y son NaN, entonces (x == x) o (y == y) es false.
      : assert(x == x && y == y, 'Coordenadas no válidas (NaN)');

  const Punto.origen() : this(0, 0); // Constructor nombrado que redirige al principal

  factory Punto.desdeMapa(Map<String, num> m) {
    // Convierte valores del mapa a double y aplica valores por defecto
    final px = (m['x'] ?? 0).toDouble();
    final py = (m['y'] ?? 0).toDouble();
    return Punto(px, py);
  }

  @override
  String toString() => 'Punto($x, $y)';
}

void main() {
  // 1) Instancias const (evaluables en compile-time)
  const p1 = Punto(5, 3);
  const p2 = Punto.origen(); // (0,0) usando constructor nombrado que redirige

  // 2) Instancia creada con factory desde un mapa (runtime)
  final p3 = Punto.desdeMapa({'x': 10, 'y': -2});

  // 3) Impresión legible gracias a toString()
  print('p1 -> $p1'); // Punto(5.0, 3.0)
  print('p2 -> $p2'); // Punto(0.0, 0.0)
  print('p3 -> $p3'); // Punto(10.0, -2.0)

  // 4) Dos objetos const con los mismos valores pueden ser LA MISMA instancia reutilizada.
  //    Por eso 'identical(a, b)' devuelve true.
  const a = Punto(1, 1);
  const b = Punto(1, 1);
  print('¿a y b son la misma instancia? ${identical(a, b)}'); // true

  // 5) Trabajar con una colección de puntos
  final puntos = <Punto>[p1, p2, p3, a];
  for (final p in puntos) {
    print('Revisando: $p');
  }

  // 6) Ejemplo: filtrar por cuadrante I (x>0 e y>0)
  final cuadranteI = puntos.where((p) => p.x > 0 && p.y > 0).toList();
  print('En cuadrante I: $cuadranteI');
}
