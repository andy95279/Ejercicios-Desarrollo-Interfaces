// 4) Patrón Singleton
//    - Una única instancia para toda la app usando 'factory' y constructor privado.
//    - Útil para servicios compartidos (BD, red, configuración, etc.).

class Conexion {
  static final Conexion _instancia = Conexion._interna(); // Instancia única (creada una vez).

  factory Conexion() => _instancia;       // Factory: siempre devuelve la misma instancia.

  Conexion._interna();                    // Constructor privado: impide instanciar desde fuera.

  void ping() => print("Conexión OK");    // Método de ejemplo.
}

void main() {
  // Uso de la clase Conexion como Singleton
  final c1 = Conexion();
  final c2 = Conexion();

  print("¿Misma instancia? ${identical(c1, c2)}"); // true
  c1.ping();                                        // Conexión OK
}
