import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
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
  Future<Either<Failure, T>> connectedAndRun<T>(Future<Either<Failure, T>> Function() action) async {
    if (!await isConnected) {
      return const Left(NetworkFailure("No Internet Connection"));
    }
    return action();
  }
}
