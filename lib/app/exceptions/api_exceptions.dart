class ApiException implements Exception {
  final String message;
  final String code;
  final String details;

  ApiException(
      {required this.message, required this.code, required this.details});

  @override
  String toString() =>
      'ApiException: (Status: $code. Message: $message. Detail: $details)';
}
