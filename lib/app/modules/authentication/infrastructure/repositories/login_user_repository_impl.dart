import 'package:smart_planner/app/modules/authentication/domain/entities/user_result.dart';
import 'package:smart_planner/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/modules/authentication/domain/repositories/login_user_repository.dart';
import 'package:smart_planner/app/modules/authentication/infrastructure/datasources/login_user_datasource.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/network_service.dart';

class LoginUserRepositoryImpl implements LoginUserRepository {
  final LoginUserDatasource datasource;
  final NetworkService _networkService;
  LoginUserRepositoryImpl(this.datasource, this._networkService);

  @override
  Future<Either<Failure, UserResult>> loginWithEmailAndPassword(
      String email, String password) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result =
          await datasource.loginWithEmailAndPassword(email, password);
      return right(result);
    } on LoginException {
      return left(LoginFailure());
    } catch (e) {
      return left(LoginFailure());
    }
  }
}
