import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:smart_planner/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/core/usecase/usecase.dart';
import 'package:smart_planner/app/core/utils/validations.dart';
import 'package:smart_planner/app/modules/authentication/domain/entities/user_create_account.dart';
import 'package:smart_planner/app/modules/authentication/domain/repositories/create_account_repository.dart';

class CreateAccountWithEmailAndPassword extends Usecase<String, Params> {
  final CreateAccountRepository _repository;

  CreateAccountWithEmailAndPassword(this._repository);

  @override
  Future<Either<Failure, String>> call(Params? params) async {
    if (params!.userCreateAccount!.email.isEmpty ||
        params.userCreateAccount!.name.isEmpty ||
        params.userCreateAccount!.password.isEmpty) {
      return left(ParamsEmptyCreateAccountFailure());
    }

    if (!Validations.emailValidation(email: params.userCreateAccount!.email) ||
        !Validations.passwordValidation(
            password: params.userCreateAccount!.password)) {
      return left(ParamsInvalidCreateAccountFailure());
    }
    return await _repository.createAccountWithEmailAndPassword(
        params.userCreateAccount!, params.image);
  }
}

class Params extends Equatable {
  final UserCreateAccount? userCreateAccount;
  final File? image;

  const Params(this.userCreateAccount, this.image);
  @override
  List<Object?> get props => [userCreateAccount, image];
}
