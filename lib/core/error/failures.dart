import 'package:equatable/equatable.dart';
import 'exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];

  /// Helper to map common exceptions to failures
  static Failure fromException(dynamic e) {
    if (e is ServerException) {
      return ServerFailure(e.message);
    } else if (e is NetworkException) {
      return NetworkFailure(e.message);
    } else if (e is UnauthorizedException) {
      return UnauthorizedFailure(e.message);
    } else if (e is CacheException) {
      return CacheFailure(e.message);
    } else {
      return ServerFailure(e.toString());
    }
  }
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}
