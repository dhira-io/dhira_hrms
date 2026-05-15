import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/theme_repository.dart';
import '../datasources/theme_local_data_source.dart';

class ThemeRepositoryImpl implements IThemeRepository {
  final IThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, ThemeMode>> getThemeMode() async {
    try {
      final mode = localDataSource.getThemeMode();
      return Right(mode);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> setThemeMode(ThemeMode mode) async {
    try {
      await localDataSource.saveThemeMode(mode);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
