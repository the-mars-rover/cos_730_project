class AccessDenied implements Exception {
  final String reason;

  AccessDenied(this.reason);

  @override
  String toString() {
    return reason;
  }
}
