// 3) Clases abstractas e “interfaces” (implícitas con 'implements')
//    - 'abstract' declara métodos sin implementación.
//    - 'implements' obliga a implementar TODOS los miembros del contrato.

abstract class Figura {
  double area();                             // Método abstracto.
}

class Rectangulo implements Figura {         // "Implements" trata a Figura como interfaz.
  final double ancho, alto;
  Rectangulo(this.ancho, this.alto);

  @override
  double area() => ancho * alto;
}

class Circulo implements Figura {
  final double radio;
  Circulo(this.radio);

  @override
  double area() => 3.1415926 * radio * radio;
}

void imprimirArea(Figura f) {
  print('Área: ${f.area()}');
}

void main() {
  final r = Rectangulo(3, 4);
  final c = Circulo(2.5);

  imprimirArea(r); // 12
  imprimirArea(c); // 19.63...
}
