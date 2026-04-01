class AppException implements Exception {
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix $_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error during communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorizedException extends AppException {
  UnauthorizedException([message]) : super(message, "Unauthorized: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}

class AuthenticationException extends AppException {
  AuthenticationException([message]) : super(message, "Authentication failed");
}
