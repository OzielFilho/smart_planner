import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/core/utils/validations.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/controllers/app_state.dart';
import '../../../domain/entities/user_create_account.dart';
import '../../../domain/usecases/create_account/create_account_with_email_and_password.dart';
import 'create_account_event.dart';

class CreateAccountWithEmailAndPasswordBloc
    extends Bloc<CreateAccountEvent, AppState> implements Disposable {
  final CreateAccountWithEmailAndPassword _createAccountWithEmailAndPassword;
  CreateAccountWithEmailAndPasswordBloc(this._createAccountWithEmailAndPassword)
      : super(InitialState()) {
    on<CreateAccountWithEmailAndPasswordEvent>(
        _onCreateAccountWithEmailAndPasswordEvent);
  }
  void _onCreateAccountWithEmailAndPasswordEvent(
      CreateAccountWithEmailAndPasswordEvent event,
      Emitter<AppState> emit) async {
    emit(ProcessingState());
    if (event.password != event.passwordConfirme) {
      emit(ErrorState('As senhas não correspondem'));
      return;
    }
    if (!Validations.passwordValidation(password: event.passwordConfirme)) {
      emit(ParamsCreateAccountInvalidErrorState('Dados inválidos'));
      return;
    }
    final user =
        UserCreateAccount(event.name, event.email, event.password, event.photo);

    final params = Params(user, event.fileImage);
    final result = await _createAccountWithEmailAndPassword.call(params);
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case ParamsEmptyCreateAccountFailure:
          return ParamsCreateAccountEmptyErrorState('Dados vazios');
        case ParamsInvalidCreateAccountFailure:
          return ParamsCreateAccountInvalidErrorState('Dados inválidos');
        case NetworkFailure:
          return NetworkErrorState('Sem conexão com a internet');
        default:
          return ErrorState('Serviço Indiponível no Momento!');
      }
    }, (success) {
      return success.isEmpty
          ? SuccessCreateAccountState()
          : ErrorState(success);
    }));
  }

  @override
  void dispose() => close();
}
