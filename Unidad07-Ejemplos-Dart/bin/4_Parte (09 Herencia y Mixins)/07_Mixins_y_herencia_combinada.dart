// 7) Mixins + Herencia combinada (caso práctico)

class Servicio {
  void log(String msg) => print('[Servicio] $msg');  // Comportamiento común.
}

mixin Reintentable {
  Future<T> reintentar<T>(Future<T> Function() accion, {int veces = 2}) async {
    int intento = 0;
    while (true) {
      intento++;
      try {
        return await accion();
      } catch (e) {
        if (intento >= veces) rethrow;
      }
    }
  }
}

mixin Cacheable {
  final Map<String, String> _cache = {}; // Caché en memoria (simple).
  String? leerCache(String k) => _cache[k];
  void guardarCache(String k, String v) => _cache[k] = v;
}

class ApiService extends Servicio with Reintentable, Cacheable {
  Future<String> obtenerDato(String clave) async {
    final enCache = leerCache(clave);
    if (enCache != null) {
      log('Cache hit: $clave');
      return enCache;
    }

    final resultado = await reintentar<String>(() async {
      log('Llamando API para $clave...');
      return 'valor_de_$clave';
    }, veces: 2);

    guardarCache(clave, resultado);
    return resultado;
  }
}

Future<void> main() async {
  final api = ApiService();

  print(await api.obtenerDato('perfil'));  // Llama y cachea.
  print(await api.obtenerDato('perfil'));  // Cache hit.
}
