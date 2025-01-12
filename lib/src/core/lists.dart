///
/// Extension on List
///
extension Lists<E> on List<E> {
  // Returns the first element that satisfies the given predicate [test].
  E? findFirst(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
