import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class SplashRepository {
  Future<Either<Failure, bool>> getUserLogged();
}
