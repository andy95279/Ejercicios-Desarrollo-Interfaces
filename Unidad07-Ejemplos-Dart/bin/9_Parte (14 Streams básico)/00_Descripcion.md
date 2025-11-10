# 14 — Streams básico en Dart

## Qué van a aprender
1) **Concepto de Stream** y consumo con `await for` y `listen`.
2) **Creación de streams**: `Stream.fromIterable`, `Stream.periodic` y `StreamController`.
3) **Single‑subscription vs Broadcast**: diferencias y casos de uso.
4) **Transformaciones**: `map`, `where`, `take`, `skip`, `asyncMap`, `asyncExpand`.
5) **Control de suscripción**: `pause()`, `resume()`, `cancel()`; `isPaused`.
6) **Manejo de errores**: `addError`, `onError`, `try/catch` con `await for`.
7) **Transformers personalizados**: `StreamTransformer<T,R>` básico.
8) **Combinación de streams (merge simple)** con `StreamController` sin librerías externas.

> Recomendación: ejecuta `00_Tour.dart` para ver los ejemplos en orden.
