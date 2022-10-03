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

class SuccessHomeState extends SuccessState {}

class SuccessRecoveryState extends SuccessState {}
