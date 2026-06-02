import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';
import '../../../../core/utils/string_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final LocalStorageService localStorageService;

  AuthRepositoryImpl(
    this.remoteDataSource,
    this.networkInfo,
    this.localStorageService,
  );

  @override
  Future<Either<Failure, UserEntity>> signIn(
    String email,
    String password,
  ) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final UserModel userModel = await remoteDataSource.signIn(
          email,
          password,
        );
        final userEntity = userModel.toEntity();

        await localStorageService.saveUserEmail(email);
        await localStorageService.saveUserFullname(userEntity.fullName);
        await localStorageService.saveEmpId(userEntity.empId);
        await localStorageService.saveEmpName(userEntity.fullName);
        await localStorageService.saveIsFirstTime(false);

        if (userEntity.department != null) {
          await localStorageService.saveDepartment(userEntity.department!);
        }
        if (userEntity.approver != null) {
          final leaveApproverName = StringUtils.formatNameFromEmail(
            userEntity.approver!,
            capitalizeEach: true,
          );
          await localStorageService.saveApproverName(leaveApproverName);
          await localStorageService.saveApprover(userEntity.approver!);
        }
        if (userEntity.gender != null) {
          await localStorageService.saveGender(userEntity.gender!);
        }

        // Read latest cookies (which should have the new sid from AuthInterceptor)
        final currentCookies = localStorageService.getCookieMap() ?? {};

        // Merge without overwriting the sid if it exists in currentCookies
        final Map<String, String> setCookieMap = {
          ...currentCookies,
          "full_name": userEntity.fullName,
          "system_user": "yes",
          "user_id": email,
          "user_image": userEntity.userImage ?? "",
        };

        await localStorageService.saveCookieMap(setCookieMap);

        return Right(userEntity);
      } catch (e) {
        try {
          await remoteDataSource.logout();
        } catch (_) {}
        await localStorageService.clearAll();
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return networkInfo.connectedAndRun(() async {
      try {
        try {
          await remoteDataSource.logout();
        } catch (_) {
          // Ignore API failure (e.g., token expired 401)
        }
        await localStorageService.clearAll();
        svg.cache.clear();
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    return networkInfo.connectedAndRun(() async {
      try {
        final email = localStorageService.getUserEmail();
        if (email == null) {
          return const Left(CacheFailure("No user session found"));
        }

        final userModel = await remoteDataSource.getEmployeeDetails(email);

        var userEntity = userModel.toEntity();
        if (userEntity.approver == null) {
          userEntity = userEntity.copyWith(
            approver: localStorageService.getApprover(),
          );
        }
        if (userEntity.department == null) {
          userEntity = userEntity.copyWith(
            department: localStorageService.getDepartment(),
          );
        }
        if (userEntity.gender != null) {
          await localStorageService.saveGender(userEntity.gender!);
        } else {
          userEntity = userEntity.copyWith(
            gender: localStorageService.getGender(),
          );
        }

        return Right(userEntity);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<bool> isSessionActive() async {
    final cookieMap = localStorageService.getCookieMap();
    if (cookieMap == null) return false;

    final sid = cookieMap['sid'];
    return sid != null && sid != "Guest" && sid.isNotEmpty;
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.forgotPassword(email);
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> initiateMicrosoftSSO() async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.initiateMicrosoftSSO();
        return const Right(null);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, UserEntity>> exchangeSSOToken(
    String apiKey,
    String apiSecret,
  ) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final UserModel userModel = await remoteDataSource.exchangeToken(
          apiKey,
          apiSecret,
        );
        final userEntity = userModel.toEntity();

        await localStorageService.saveUserEmail(userEntity.email);
        await localStorageService.saveUserFullname(userEntity.fullName);
        await localStorageService.saveEmpId(userEntity.empId);
        await localStorageService.saveEmpName(userEntity.fullName);
        await localStorageService.saveIsFirstTime(false);

        if (userEntity.department != null) {
          await localStorageService.saveDepartment(userEntity.department!);
        }
        if (userEntity.approver != null) {
          final leaveApproverName = StringUtils.formatNameFromEmail(
            userEntity.approver!,
            capitalizeEach: true,
          );
          await localStorageService.saveApproverName(leaveApproverName);
          await localStorageService.saveApprover(userEntity.approver!);
        }

        // Read latest cookies (which should have the new sid from AuthInterceptor)
        final currentCookies = localStorageService.getCookieMap() ?? {};

        // Merge without overwriting the sid if it exists in currentCookies
        final Map<String, String> setCookieMap = {
          ...currentCookies,
          "full_name": userEntity.fullName,
          "system_user": "yes",
          "user_id": userEntity.email,
          "user_image": userEntity.userImage ?? "",
        };

        await localStorageService.saveCookieMap(setCookieMap);

        return Right(userEntity);
      } catch (e) {
        try {
          await remoteDataSource.logout();
        } catch (_) {}
        await localStorageService.clearAll();
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(String email, String otp) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final result = await remoteDataSource.verifyOtp(email, otp);
        return Right(result);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, bool>> resendOtp(String email) async {
    return networkInfo.connectedAndRun(() async {
      try {
        final result = await remoteDataSource.resendOtp(email);
        return Right(result);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }
}
