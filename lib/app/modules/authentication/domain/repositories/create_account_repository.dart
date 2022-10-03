import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/modules/authentication/domain/entities/user_create_account.dart';

import '../../../../core/errors/failure.dart';

abstract class CreateAccountRepository {
  Future<Either<Failure, String>> createAccountWithEmailAndPassword(
      UserCreateAccount user);
}
