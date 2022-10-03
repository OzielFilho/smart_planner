import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/core/errors/failure.dart';

import 'package:smart_planner/app/core/usecase/usecase.dart';
import 'package:smart_planner/app/modules/authentication/domain/repositories/recovery_password_repository.dart';

import '../../../../../core/utils/validations.dart';

class RecoveryWithEmail extends Usecase<String, String> {
  final RecoveryPasswordRepository _repository;

  RecoveryWithEmail(this._repository);

  @override
  Future<Either<Failure, String>> call(String? params) async {
    if (params!.isEmpty) {
      return left(ParamsEmptyRecoveryPasswordFailure());
    }

    if (!Validations.emailValidation(email: params)) {
      return left(ParamsInvalidRecoveryPasswordFailure());
    }
    return await _repository.recoveryWithEmail(params);
  }
}
