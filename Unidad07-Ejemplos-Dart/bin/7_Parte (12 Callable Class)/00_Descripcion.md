# 12 — Clases "callable" en Dart (`call()`)

## Qué van a aprender
1) **Concepto básico:** una clase es *callable* si implementa el método especial `call(…)`. Sus instancias pueden usarse como si fueran funciones.
2) **Parámetros posicionales/nombrados y por defecto:** cómo diseñar APIs de `call` cómodas para el uso diario.
3) **Genéricos con `call`:** factorías y transformaciones fuertemente tipadas (p. ej., `T -> R`).
4) **Funciones de orden superior:** pasar instancias *callable* donde se espera un `Function`, `typedef` o firma concreta (ej.: `int Function(int)`).
5) **Estado interno + callable:** crear *function objects* que recuerdan estado (alternativa a closures).
6) **`call` asíncrono:** `Future`/`Stream` como retorno y su consumo (`await`, `await for`).
7) **Comparativa con closures y tear-offs:** cuándo preferir clases *callable* (reutilización, testabilidad, estado, inyección de dependencias).
8) **Caso práctico (pipeline sencillo):** encadenar pasos *callable* para procesar datos.

> Recomendación: ejecuta `00_Tour.dart` para ver los ejemplos en orden.
