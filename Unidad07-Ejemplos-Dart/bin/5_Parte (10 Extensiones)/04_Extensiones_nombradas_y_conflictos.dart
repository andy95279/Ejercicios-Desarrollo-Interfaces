// 4) Extensiones nombradas y resolución de conflictos
//    - Dos extensiones pueden definir el mismo método. ¿Cuál se usa?
//    - Para forzar una u otra, usa la INVOCACIÓN EXPLÍCITA de extensión: ExtensionName(valor).metodo().

extension SaludoFormal on String {
  String saludar() => "Estimado/a $this";
}

extension SaludoInformal on String {
  String saludar() => "¡Hey $this!";
}

void main() {
  final nombre = "Ana";
  print(SaludoFormal(nombre).saludar());   // "Estimado/a Ana"
  print(SaludoInformal(nombre).saludar()); // "¡Hey Ana!"
}
