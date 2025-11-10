// 2) Parámetros nombrados con valores por defecto en `call` (versión robusta).
class Formateador {
  // Rellena a la derecha hasta 'ancho' usando 'relleno' (por defecto: espacio).
  String call(
    String s, {
    int ancho = 10,
    String relleno = ' ',
  }) {
    // Si ya alcanza el ancho, devolver tal cual.
    if (s.length >= ancho) return s;
    // padRight repite la cadena de relleno las veces necesarias.
    return s.padRight(ancho, relleno);
  }
}

void main() {
  final fmt = Formateador();
  print(fmt('Dart'));                       // "Dart      "
  print(fmt('Dart', ancho: 8));             // "Dart    "
  print(fmt('Dart', ancho: 8, relleno: '.')); // "Dart...."
}
