List<int> countPositivesSumNegatives(List<int>? input) {
  // Si la lista es nula o está vacía, devolvemos una lista vacía
  if (input == null || input.isEmpty) return [];

  // Variable para contar la cantidad de números positivos
  int countPos = 0;

  // Variable para acumular la suma de los números negativos
  int sumNeg = 0;

  // Recorremos cada número en la lista
  for (var num in input) {
    if (num > 0) {
      // Si el número es positivo, aumentamos el contador
      countPos++;
    } else if (num < 0) {
      // Si el número es negativo, lo sumamos al acumulador
      sumNeg += num;
    }
    // Si el número es 0, lo ignoramos (no se cuenta ni suma)
  }

  // Devolvemos una lista con dos valores:
  // [cantidad de positivos, suma de negativos]
  return [countPos, sumNeg];
}
