class PermissionDenied implements Exception {
  final String error;

  PermissionDenied(this.error);

  @override
  String toString() {
    return error;
  }
}
