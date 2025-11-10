// 3) Encapsulación + getters/setters + propiedad derivada
//    - Campos privados (_ancho/_alto), validación en constructor y setters.
//    - Getter derivado 'area' (solo lectura). Buenas prácticas de invariantes.

class Rectangulo {
  double _ancho;                         // Campo privado (nivel de biblioteca).
  double _alto;

  Rectangulo(double ancho, double alto)  // Constructor con lista de inicialización y assert.
      : assert(ancho > 0 && alto > 0, "Ancho y alto deben ser > 0"),
        _ancho = ancho,
        _alto = alto;

  double get ancho => _ancho;            // Getter de '_ancho'.
  double get alto  => _alto;             // Getter de '_alto'.

  set ancho(double v) {                  // Setter con validación.
    if (v <= 0) throw ArgumentError("El ancho debe ser > 0");
    _ancho = v;
  }

  set alto(double v) {                   // Setter con validación.
    if (v <= 0) throw ArgumentError("El alto debe ser > 0");
    _alto = v;
  }

  double get area => _ancho * _alto;     // Propiedad derivada: calcula el área al vuelo.

  @override
  String toString() => "Rectangulo(ancho: $_ancho, alto: $_alto, area: $area)";
}

void main() {
  // Uso de la clase Rectangulo
  final r = Rectangulo(3, 4);
  print(r);                              // -> Rectangulo(ancho: 3.0, alto: 4.0, area: 12.0)

  r.ancho = 5;                           // Setter con validación.
  print("Nueva área: ${r.area}");        // -> 20.0

  // Ejemplo de validación (descomentar para probar la excepción):
  // r.alto = -1; // ArgumentError
}
