import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/modules/home/domain/usecases/todo_list/get_list_todo.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/controllers/app_state.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/todo_group_item.dart';
import 'todo_list_event.dart';

class GetTodoListBloc extends Bloc<TodoListEvent, AppState>
    implements Disposable {
  final GetListTodo _usecase;
  GetTodoListBloc(this._usecase) : super(InitialState()) {
    on<GetTodoListEvent>(_onGetTodoListEvent);
  }

  List<TodoGroupItem> resultList = [];

  @override
  void dispose() => close();

  _onGetTodoListEvent(GetTodoListEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());

    final result = await _usecase.call(NoParams());
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case EmptyListTodoFailure:
          return EmptyTodoListState('Você não possui tarefas');
        default:
          return GetTodoListErrorState('Indisponível no momento');
      }
    }, (r) {
      resultList = r;
      return SuccessGetTodoListState();
    }));
  }
}
