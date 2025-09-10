extension AssociateBy<T> on List<T> {
  Map<K, T> associateBy<K>(K Function(T) keySelector) {
    return {for (var element in this) keySelector(element): element};
  }
}
