// 1) Extensiones básicas en String
//    - Añadimos métodos de utilidad a String sin heredar ni modificar la clase original.
//    - Útil para encapsular transformaciones frecuentes (capitalizar, invertir, palabras).

extension StringUtils on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  String reverse() {
    return String.fromCharCodes(runes.toList().reversed);
  }

  List<String> words() {
    return trim().split(RegExp(r'\s+'));
  }
}

void main() {
  final s = "hola mundo dart";
  print(s.capitalize());    // "Hola mundo dart"
  print("Radar".reverse()); // "radaR"
  print("  uno   dos  tres ".words()); // ["uno","dos","tres"]
}
