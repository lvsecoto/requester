extension ListEx<E> on List<E> {

  /// 用[test]找到条目，然后[update]条目，返回一个新列表
  List<E> update(
      bool Function(E it) test,
      E Function(E it) update,
      ) {
    final index = indexWhere(test);
    if (index != -1) {
      return [
        ...this
      ]..[index] = update(this[index]);
    }
    return this;
  }
}