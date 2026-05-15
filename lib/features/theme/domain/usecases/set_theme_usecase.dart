import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';
import '../repositories/theme_repository.dart';

class SetThemeUseCase {
  final IThemeRepository repository;

  SetThemeUseCase(this.repository);

  Future<Either<Failure, Unit>> call(ThemeMode mode) async {
    return await repository.setThemeMode(mode);
  }
}
