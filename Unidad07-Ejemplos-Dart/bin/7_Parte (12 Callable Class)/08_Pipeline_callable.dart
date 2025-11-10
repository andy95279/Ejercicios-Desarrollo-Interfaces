// 8) Caso práctico: pipeline de pasos "callable"
//    - Cada paso transforma un String y se pueden encadenar fácilmente.

abstract class Paso {
  String call(String entrada);
}

class TrimPaso implements Paso {
  @override
  String call(String e) => e.trim();
}

class LowerPaso implements Paso {
  @override
  String call(String e) => e.toLowerCase();
}

class ReemplazarPaso implements Paso {
  final String buscar, por;
  ReemplazarPaso(this.buscar, this.por);

  @override
  String call(String e) => e.replaceAll(buscar, por);
}

class Pipeline {
  final List<Paso> _pasos;
  Pipeline(this._pasos);

  String procesar(String input) {
    var out = input;
    for (final p in _pasos) {
      out = p(out); // invoca cada paso como función
    }
    return out;
  }
}

void main() {
  final pipe = Pipeline([
    TrimPaso(),
    LowerPaso(),
    ReemplazarPaso('dart', 'Dart'),
  ]);

  print(pipe.procesar('   Hola DART   ')); // "hola Dart"
}
