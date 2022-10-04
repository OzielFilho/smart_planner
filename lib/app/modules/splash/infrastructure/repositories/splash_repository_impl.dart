import 'package:smart_planner/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/core/services/network_service.dart';
import 'package:smart_planner/app/modules/splash/domain/repositories/splash_repository.dart';
import 'package:smart_planner/app/modules/splash/infrastructure/datasource/splash_datasource.dart';

import '../../../../core/errors/exceptions.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashDatasource _datasource;
  final NetworkService _networkService;
  SplashRepositoryImpl(this._datasource, this._networkService);
  @override
  Future<Either<Failure, bool>> getUserLogged() async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await _datasource.getUserLogged();
      return right(result);
    } on LoggedUserException {
      return left(LoggedUserFailure());
    } catch (e) {
      return left(LoggedUserFailure());
    }
  }
}
