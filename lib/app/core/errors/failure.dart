import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List props = const <dynamic>[]]);
}

class NetworkFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class LoginFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class CreateUserFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class RecoveryPasswordFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class ParamsEmptyLoginFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}

class ParamsInvalidLoginFailure extends Failure {
  @override
  List<Object?> get props => const <dynamic>[];
}
