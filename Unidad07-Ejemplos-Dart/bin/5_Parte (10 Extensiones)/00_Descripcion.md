# 10 — Extensiones en Dart

## Qué van a aprender
1) **Extensiones básicas en `String`**: añadir métodos de utilidad sin modificar la clase original.
2) **Extensiones en tipos primitivos (`int`)**: utilidades como `isPrime` o `times(void Function())`.
3) **Extensiones genéricas en colecciones**: métodos sobre `List<T>` como `firstOrNull`, `chunked` o sumas numéricas.
4) **Extensiones nombradas y resolución de conflictos**: cómo elegir qué extensión usar cuando hay nombres coincidentes.
5) **Extensiones sobre tipos anulables** (`T?`): patrones comunes como `orEmpty`, `safeLength`, etc.
6) **Extensiones con restricciones genéricas** (`T extends num`): operaciones numéricas seguras en genéricos.

> Recomendación: ejecuta `00_Tour.dart` para ver todos los ejemplos en orden.
