import 'package:smart_planner/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/core/usecase/usecase.dart';
import 'package:smart_planner/app/modules/splash/domain/repositories/splash_repository.dart';

class GetUserLogged extends Usecase<bool, NoParams> {
  final SplashRepository _repository;

  GetUserLogged(this._repository);
  @override
  Future<Either<Failure, bool>> call(NoParams? params) async {
    return await _repository.getUserLogged();
  }
}
