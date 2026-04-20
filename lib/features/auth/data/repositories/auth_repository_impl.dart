import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
import '../../../../core/utils/string_utils.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.remoteDataSource, this.networkInfo);

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

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(StorageConstants.userEmail, email);
        await prefs.setString(
          StorageConstants.userFullname,
          userEntity.fullName,
        );
        await prefs.setString(StorageConstants.empId, userEntity.empId);
        await prefs.setString(StorageConstants.empName, userEntity.fullName);

        if (userEntity.department != null) {
          await prefs.setString(
            StorageConstants.department,
            userEntity.department!,
          );
        }
        if (userEntity.approver != null) {
          final leaveApproverName = StringUtils.formatNameFromEmail(
            userEntity.approver!,
            capitalizeEach: true,
          );
          await prefs.setString(
            StorageConstants.leaveApproverName,
            leaveApproverName,
          );
          await prefs.setString(
            StorageConstants.leaveApprover,
            userEntity.approver!,
          );
        }

        // Construct and save setCookieMap (Requested by USER)
        final cookieString = prefs.getString(StorageConstants.cookies);
        String sid = "";
        if (cookieString != null) {
          final Map<String, dynamic> cookieMap = json.decode(cookieString);
          sid = cookieMap['sid'] ?? "";
        }

        final Map<String, String> setCookieMap = {
          "full_name": userEntity.fullName,
          "sid": sid,
          "system_user": "yes",
          "user_id": email,
          "user_image": userEntity.userImage ?? "",
        };
        await prefs.setString(
          StorageConstants.cookies,
          json.encode(setCookieMap),
        );
        await prefs.setString(StorageConstants.sid, sid);

        return Right(userEntity);
      } catch (e) {
        return Left(Failure.fromException(e));
      }
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return networkInfo.connectedAndRun(() async {
      try {
        await remoteDataSource.logout();
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
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
        final prefs = await SharedPreferences.getInstance();
        final email = prefs.getString(StorageConstants.userEmail);
        if (email == null) {
          return const Left(CacheFailure("No user session found"));
        }

        final userModel = await remoteDataSource.getEmployeeDetails(email);

        var userEntity = userModel.toEntity();
        if (userEntity.approver == null) {
          userEntity = userEntity.copyWith(
            approver: prefs.getString(StorageConstants.leaveApprover),
          );
        }
        if (userEntity.department == null) {
          userEntity = userEntity.copyWith(
            department: prefs.getString(StorageConstants.department),
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
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(StorageConstants.cookies);
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

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(StorageConstants.userEmail, userEntity.email);
        await prefs.setString(
          StorageConstants.userFullname,
          userEntity.fullName,
        );
        await prefs.setString(StorageConstants.empId, userEntity.empId);
        await prefs.setString(StorageConstants.empName, userEntity.fullName);

        if (userEntity.department != null) {
          await prefs.setString(
            StorageConstants.department,
            userEntity.department!,
          );
        }
        if (userEntity.approver != null) {
          final leaveApproverName = StringUtils.formatNameFromEmail(
            userEntity.approver!,
            capitalizeEach: true,
          );
          await prefs.setString(
            StorageConstants.leaveApproverName,
            leaveApproverName,
          );
          await prefs.setString(
            StorageConstants.leaveApprover,
            userEntity.approver!,
          );
        }

        // Construct and save setCookieMap (Requested by USER)
        final cookieString = prefs.getString(StorageConstants.cookies);
        String sid = "";
        if (cookieString != null) {
          final Map<String, dynamic> cookieMap = json.decode(cookieString);
          sid = cookieMap['sid'] ?? "";
        }

        final Map<String, String> setCookieMap = {
          "full_name": userEntity.fullName,
          "sid": sid,
          "system_user": "yes",
          "user_id": userEntity.email,
          "user_image": userEntity.userImage ?? "",
        };
        await prefs.setString(
          StorageConstants.cookies,
          json.encode(setCookieMap),
        );
        await prefs.setString(StorageConstants.sid, sid);

        return Right(userEntity);
      } catch (e) {
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
