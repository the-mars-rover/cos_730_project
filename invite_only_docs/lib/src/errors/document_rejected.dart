class DocumentedRejected implements Exception {
  /// The reason why the document was rejected.
  final String reason;

  DocumentedRejected(this.reason);

  @override
  String toString() => 'MissingPluginException($reason)';
}