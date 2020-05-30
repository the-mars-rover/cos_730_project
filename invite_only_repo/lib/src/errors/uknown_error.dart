class UnknownError implements Exception {
  /// The error that could not be handled.
  final String error;

  UnknownError(this.error);
}
