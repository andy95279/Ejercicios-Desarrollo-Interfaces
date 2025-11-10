# 11 — Generators síncronos y asíncronos en Dart

## Qué van a aprender
1) **Generadores síncronos (`sync*`, `yield`)**: producir elementos bajo demanda (`Iterable<T>`).
2) **Composición con `yield*`**: delegar a otros generadores para reutilizar lógica.
3) **`Iterable` e `Iterator` personalizados**: cómo funciona por dentro un generador síncrono.
4) **Generadores asíncronos (`async*`, `yield`)**: producir eventos en un `Stream<T>` con esperas (`Future`).
5) **Consumo de `Stream`**: `await for`, `listen`, `pause/resume/cancel`.
6) **Transformación de streams**: `map`, `where`, `asyncMap`, `asyncExpand` y throttling básico.
7) **Errores en streams**: `addError`, manejo con `try/catch` y `onError`.
8) **Buenas prácticas**: cancelar suscripciones, no bloquear el event loop, separar productor/consumidor.

> Recomendación: ejecuta `00_Tour.dart` para ver los ejemplos en orden.
