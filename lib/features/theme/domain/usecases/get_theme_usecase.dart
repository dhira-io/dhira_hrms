import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';
import '../repositories/theme_repository.dart';

class GetThemeUseCase {
  final IThemeRepository repository;

  GetThemeUseCase(this.repository);

  Future<Either<Failure, ThemeMode>> call() async {
    return await repository.getThemeMode();
  }
}
