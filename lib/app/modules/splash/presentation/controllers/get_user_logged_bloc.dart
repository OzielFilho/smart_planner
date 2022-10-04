import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/core/usecase/usecase.dart';
import 'package:smart_planner/app/modules/splash/presentation/controllers/splash_event.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/presentation/controllers/app_state.dart';
import '../../domain/usecases/get_user_logged.dart';

class GetUserLoggedBloc extends Bloc<SplashEvent, AppState>
    implements Disposable {
  final GetUserLogged _usecase;
  GetUserLoggedBloc(this._usecase) : super(InitialState()) {
    on<GetUserLoggedEvent>(_onLoginWithEmailAndPasswordEvent);
  }
  void _onLoginWithEmailAndPasswordEvent(
      GetUserLoggedEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());

    final result = await _usecase.call(NoParams());
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case NetworkFailure:
          return NetworkErrorState('Sem conexão com a internet');
        default:
          return ErrorState('');
      }
    }, (success) {
      return success ? SuccessUserLoggedState() : SuccessUserLoggedLoginState();
    }));
  }

  @override
  void dispose() => close();
}
