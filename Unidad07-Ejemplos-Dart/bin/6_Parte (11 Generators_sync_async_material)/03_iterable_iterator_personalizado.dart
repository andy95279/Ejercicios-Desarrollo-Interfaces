// 3) Iterable/Iterator personalizado (cómo funciona por dentro)
//    - Útil para entender la mecánica que simplifica sync*.

class ConteoIterable extends Iterable<int> {
  final int hasta;
  ConteoIterable(this.hasta);

  @override
  Iterator<int> get iterator => _ConteoIterator(hasta);
}

class _ConteoIterator implements Iterator<int> {
  final int hasta;
  int _actual = -1;

  _ConteoIterator(this.hasta);

  @override
  int get current => _actual;

  @override
  bool moveNext() {
    if (_actual >= hasta) return false;
    _actual++;
    return _actual <= hasta;
  }
}

void main() {
  final it = ConteoIterable(3);
  for (final x in it) {
    print('x=$x');
  }
}
