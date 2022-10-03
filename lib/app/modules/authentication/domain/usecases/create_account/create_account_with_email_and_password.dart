import 'package:smart_planner/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/core/usecase/usecase.dart';
import 'package:smart_planner/app/core/utils/validations.dart';
import 'package:smart_planner/app/modules/authentication/domain/entities/user_create_account.dart';
import 'package:smart_planner/app/modules/authentication/domain/repositories/create_account_repository.dart';

class CreateAccountWithEmailAndPassword
    extends Usecase<String, UserCreateAccount> {
  final CreateAccountRepository _repository;

  CreateAccountWithEmailAndPassword(this._repository);

  @override
  Future<Either<Failure, String>> call(UserCreateAccount? params) async {
    if (params!.email.isEmpty ||
        params.name.isEmpty ||
        params.password.isEmpty) {
      return left(ParamsEmptyCreateAccountFailure());
    }

    if (!Validations.emailValidation(email: params.email) ||
        !Validations.passwordValidation(password: params.password)) {
      return left(ParamsInvalidCreateAccountFailure());
    }
    return await _repository.createAccountWithEmailAndPassword(params);
  }
}
