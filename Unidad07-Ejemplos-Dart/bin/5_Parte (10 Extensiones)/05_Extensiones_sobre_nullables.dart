// 5) Extensiones sobre tipos anulables (T?)
//    - Patrones comunes para trabajar con null de forma segura.

extension StringNullableX on String? {
  String orEmpty() => this ?? '';
  int safeLength() => this?.length ?? 0;
  bool get isBlank => (this == null) || this!.trim().isEmpty;
}

void main() {
  String? s1 = null;
  String? s2 = "  ";

  print(s1.orEmpty());        // ""
  print("hola".orEmpty());    // "hola"
  print(s1.safeLength());     // 0
  print("hola".safeLength()); // 4
  print(s2.isBlank);          // true
}
