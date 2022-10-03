import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/modules/authentication/domain/entities/user_result.dart';

import '../../../../core/errors/failure.dart';

abstract class LoginUserRepository {
  Future<Either<Failure, UserResult>> loginWithEmailAndPassword(
      String email, String password);
}
