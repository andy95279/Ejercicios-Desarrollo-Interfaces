# 13 — Futures, `async` & `await` en Dart

## Qué van a aprender
1) **`Future` básico y `then/catchError`**: cómo encadenar operaciones.
2) **`async/await`**: escribir código asíncrono con estilo secuencial.
3) **Manejo de errores**: `try/catch/finally`, `catchError`, `on`, `rethrow`.
4) **Ejecución en paralelo**: `Future.wait`, `Future.any`, `timeout` y control de tiempos.
5) **`Completer` y cancelación cooperativa**: crear futuros manuales, abortar flujos.
6) **Secuenciación vs. paralelismo**: medir tiempos y elegir estrategia.
7) **Microtasks y event loop**: orden de ejecución (`scheduleMicrotask`, `Future`).
8) **Reintentos y backoff**: patrón de reintentos con esperas crecientes.
9) **Reporte de progreso**: comunicar avance con callbacks/streams desde funciones `async`.

> Recomendación: ejecuta `00_Tour.dart` para ver los ejemplos en orden.
