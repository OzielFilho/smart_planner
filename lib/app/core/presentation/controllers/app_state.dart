class AppState {
  final String? message;

  AppState([this.message]);
}

class InitialState extends AppState {}

class ErrorState extends AppState {
  ErrorState(String? message) : super(message);
}

class NetworkErrorState extends AppState {
  NetworkErrorState(String? message) : super(message);
}

class SuccessState extends AppState {}

class ProcessingState extends AppState {}

class EmailOrPasswordEmptyErrorState extends ErrorState {
  EmailOrPasswordEmptyErrorState(super.message);
}

class EmailOrPasswordInvalidErrorState extends ErrorState {
  EmailOrPasswordInvalidErrorState(super.message);
}

class ParamsCreateAccountEmptyErrorState extends ErrorState {
  ParamsCreateAccountEmptyErrorState(super.message);
}

class ParamsCreateAccountInvalidErrorState extends ErrorState {
  ParamsCreateAccountInvalidErrorState(super.message);
}

class SuccessHomeState extends SuccessState {}

class SuccessRecoveryState extends SuccessState {}

class SuccessCreateAccountState extends SuccessState {}
