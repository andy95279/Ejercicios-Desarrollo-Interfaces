int lastChair(int n) {
  List<int> ocupadas = []; // sillas ocupadas

  while (ocupadas.length < n) {
    // Primera persona siempre se sienta en la silla 1
    if (ocupadas.isEmpty) {
      ocupadas.add(1);
      continue;
    }

    int mejorSilla = -1;
    int mejorDistancia = -1;

    // Recorremos todas las sillas posibles
    for (int silla = 1; silla <= n; silla++) {
      if (ocupadas.contains(silla)) continue; // si ya está ocupada, la saltamos

      // Buscamos la distancia mínima a cualquier silla ocupada
      int distanciaMasCercana = 999999;
      for (int otra in ocupadas) {
        int distancia = (otra - silla).abs();
        if (distancia < distanciaMasCercana) {
          distanciaMasCercana = distancia;
        }
      }

      // Si esta silla está más lejos que las demás, la elegimos
      if (distanciaMasCercana > mejorDistancia) {
        mejorDistancia = distanciaMasCercana;
        mejorSilla = silla;
      }
    }

    ocupadas.add(mejorSilla); // la persona se sienta ahí
  }

  // devolvemos la silla del último que se sentó
  return ocupadas.last;
}

void main() {
  print(lastChair(10)); // muestra: 2
}
