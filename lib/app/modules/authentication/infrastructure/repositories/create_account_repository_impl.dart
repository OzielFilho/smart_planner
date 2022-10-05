import 'dart:io';

import 'package:smart_planner/app/modules/authentication/domain/entities/user_create_account.dart';

import 'package:smart_planner/app/core/errors/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/modules/authentication/infrastructure/models/user_create_account_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/network_service.dart';
import '../../domain/repositories/create_account_repository.dart';
import '../datasources/create_account_datasource.dart';

class CreateAccountRepositoryImpl implements CreateAccountRepository {
  final CreateAccountDatasource _datasource;
  final NetworkService _networkService;
  CreateAccountRepositoryImpl(this._datasource, this._networkService);

  @override
  Future<Either<Failure, String>> createAccountWithEmailAndPassword(
      UserCreateAccount user, File? image) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await _datasource.createAccountWithEmailAndPassword(
          UserCreateAccountModel.fromUser(user), image);
      return right(result);
    } on CreateAccountException {
      return left(CreateUserFailure());
    } catch (e) {
      return left(CreateUserFailure());
    }
  }
}
