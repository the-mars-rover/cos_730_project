class Unauthorized implements Exception {
  /// The reason for authorization failing.
  final String reason;

  Unauthorized(this.reason);
}
