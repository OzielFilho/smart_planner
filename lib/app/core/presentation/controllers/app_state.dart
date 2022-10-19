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

class EmailNotConfirmedState extends ErrorState {
  EmailNotConfirmedState(super.message);
}

class EmptyTodoListState extends ErrorState {
  EmptyTodoListState(super.message);
}

class EmptyParamsAddNewItemState extends ErrorState {
  EmptyParamsAddNewItemState(super.message);
}

class GetTodoListErrorState extends ErrorState {
  GetTodoListErrorState(super.message);
}

class AddNewItemInTodoListErrorState extends ErrorState {
  AddNewItemInTodoListErrorState(super.message);
}

class SuccessRecoveryState extends SuccessState {}

class SuccessCreateAccountState extends SuccessState {}

class SuccessUserLoggedState extends SuccessState {}

class SuccessUserLoggedLoginState extends SuccessState {}

class SuccessGetTodoListState extends SuccessState {}

class SuccessAddNewItemInTodoListState extends SuccessState {}
