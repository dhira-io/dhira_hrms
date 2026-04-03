class ServerException implements Exception {
  final String? message;
  const ServerException([this.message]);
}

class CacheException implements Exception {}

class NetworkException implements Exception {}

class ValidationException implements Exception {
  final String message;
  const ValidationException(this.message);
}
