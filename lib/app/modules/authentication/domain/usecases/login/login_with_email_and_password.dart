import 'package:equatable/equatable.dart';
import 'package:smart_planner/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/core/usecase/usecase.dart';
import 'package:smart_planner/app/core/utils/validations.dart';
import 'package:smart_planner/app/modules/authentication/domain/entities/user_result.dart';
import 'package:smart_planner/app/modules/authentication/domain/repositories/login_user_repository.dart';

class LoginWithEmailAndPassword implements Usecase<UserResult, Params> {
  final LoginUserRepository repository;

  LoginWithEmailAndPassword(this.repository);

  @override
  Future<Either<Failure, UserResult>> call(Params? params) async {
    if (params!.email.isEmpty || params.password.isEmpty) {
      return left(ParamsEmptyLoginFailure());
    }

    if (!Validations.emailValidation(email: params.email)) {
      return left(ParamsInvalidLoginFailure());
    }

    if (!Validations.passwordValidation(password: params.password)) {
      return left(ParamsInvalidLoginFailure());
    }

    return await repository.loginWithEmailAndPassword(
        params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;
  const Params({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
