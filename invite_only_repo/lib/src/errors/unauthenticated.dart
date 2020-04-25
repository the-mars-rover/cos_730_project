class Unauthenticated implements Exception {
  final String error;

  Unauthenticated(this.error);

  @override
  String toString() {
    return error;
  }
}
