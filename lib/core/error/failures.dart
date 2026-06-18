import 'package:equatable/equatable.dart';
import 'exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? code;
  const Failure(this.message, {this.code});

  @override
  List<Object?> get props => [message, code];

  bool get isServerSideError => code != null && code! >= 500 && code! < 600;

  /// Helper to map common exceptions to failures
  static Failure fromException(dynamic e) {
    if (e is ServerException) {
      return ServerFailure(e.message, code: e.code);
    } else if (e is NetworkException) {
      return NetworkFailure(e.message);
    } else if (e is UnauthorizedException) {
      return UnauthorizedFailure(e.message);
    } else if (e is CacheException) {
      return CacheFailure(e.message);
    } else {
      String msg = e.toString();
      if (msg.startsWith('Exception: ')) {
        msg = msg.replaceFirst('Exception: ', '');
      }
      return ServerFailure(msg);
    }
  }
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.code});
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.code});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message, {super.code});
}
