import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class RecoveryPasswordRepository {
  Future<Either<Failure, String>> recoveryWithEmail(String email);
}
