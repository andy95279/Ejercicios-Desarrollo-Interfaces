# 08 — POO y Constructores en Dart

## Qué vas a ver (en este orden) y qué hace cada parte

1) **Clase simple**
   - Campos mutables, constructor abreviado, método de instancia y `toString()`.
   - Demuestra cómo crear objetos y definir comportamiento.

2) **Clase inmutable con `const` y constructores nombrados/redirigidos**
   - Uso de `final` para inmutabilidad y `const` para instancias en tiempo de compilación.
   - Constructor nombrado que redirige (`: this(...)`) y `factory` desde mapa (JSON-like).
   - Validación con `assert` en lista de inicialización.

3) **Encapsulación + getters/setters + propiedad derivada**
   - Campos privados (`_ancho`/`_alto`), validación en constructor y setters.
   - Getter derivado `area` (solo lectura). Buenas prácticas de invariantes.

4) **Patrón Singleton con `factory`**
   - Una única instancia para toda la app (útil para servicios).
   - Constructor privado + `factory` que devuelve la misma instancia.

> Recomendación: abre cada `.dart`, ejecútalo y lee los comentarios en línea.
