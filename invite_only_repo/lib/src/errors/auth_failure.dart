class AuthFailure implements Exception {
  final String reason;

  AuthFailure(this.reason);
}