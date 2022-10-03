import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/modules/authentication/presentation/controllers/recovery_password_user_controller/recovery_password_event.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/controllers/app_state.dart';
import '../../../domain/usecases/recovery_password/recovery_with_email.dart';

class RecoveryPasswordWithEmailBloc
    extends Bloc<RecoveryPasswordEvent, AppState> implements Disposable {
  final RecoveryWithEmail _recoveryPasswordUser;
  RecoveryPasswordWithEmailBloc(this._recoveryPasswordUser)
      : super(InitialState()) {
    on<RecoveryPasswordWithEmailEvent>(_onRecoveryPasswordWithEmailEvent);
  }
  void _onRecoveryPasswordWithEmailEvent(
      RecoveryPasswordWithEmailEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());

    final result = await _recoveryPasswordUser.call(event.email);
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case ParamsEmptyRecoveryPasswordFailure:
          return EmailOrPasswordEmptyErrorState('Email está vazio');
        case ParamsInvalidRecoveryPasswordFailure:
          return EmailOrPasswordInvalidErrorState('Email inválido');
        case NetworkFailure:
          return NetworkErrorState('Sem conexão com a internet');
        default:
          return ErrorState('Serviço Indiponível no Momento!');
      }
    }, (success) {
      return success.isEmpty ? SuccessRecoveryState() : ErrorState(success);
    }));
  }

  @override
  void dispose() => close();
}
