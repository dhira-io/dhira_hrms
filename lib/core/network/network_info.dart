import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/error/exceptions.dart';
import '../error/failures.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result.any((element) => element != ConnectivityResult.none);
  }
}

extension RepositoryNetworkCheck on NetworkInfo {
  /// A functional wrapper that checks for internet connectivity before executing an action.
  /// Returns a [NetworkFailure] if offline, otherwise returns the result of the [action].
  Future<Either<Failure, T>> connectedAndRun<T>(
    Future<Either<Failure, T>> Function() action,
  ) async {
    if (!await isConnected) {
      return const Left(NetworkFailure("No Internet Connection"));
    }
    return action();
  }

  /// Combined wrapper for connectivity check and exception handling.
  Future<Either<Failure, T>> executeSafely<T>(Future<T> Function() call) {
    return connectedAndRun(() {
      return _safeApiCall(call);
    });
  }

  /// Private helper to map common exceptions to failures.
  Future<Either<Failure, T>> _safeApiCall<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
