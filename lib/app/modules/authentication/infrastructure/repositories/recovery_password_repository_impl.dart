import 'package:smart_planner/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/modules/authentication/infrastructure/datasources/recovery_password_datasource.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/network_service.dart';
import '../../domain/repositories/recovery_password_repository.dart';

class RecoveryPasswordRepositoryImpl implements RecoveryPasswordRepository {
  final RecoveryPasswordDatasource _datasource;
  final NetworkService _networkService;
  RecoveryPasswordRepositoryImpl(this._datasource, this._networkService);

  @override
  Future<Either<Failure, String>> recoveryWithEmail(String email) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await _datasource.recoveryWithEmail(email);
      return right(result);
    } on RecoveryPasswordException {
      return left(RecoveryPasswordFailure());
    } catch (e) {
      return left(RecoveryPasswordFailure());
    }
  }
}
