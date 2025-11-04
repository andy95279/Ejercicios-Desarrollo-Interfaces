bool isLeapYear(int year) {
  // Si el año es divisible entre 400, es bisiesto.
  // (Ejemplo: 2000, 2400)
  if (year % 400 == 0) return true;

  // Si el año es divisible entre 100 (pero no entre 400), NO es bisiesto.
  // (Ejemplo: 1900, 2100)
  if (year % 100 == 0) return false;

  // Si el año es divisible entre 4 (pero no entre 100), es bisiesto.
  // (Ejemplo: 2004, 2020)
  return year % 4 == 0;
}
