import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/modules/home/domain/usecases/todo_list/add_item_in_list_todo.dart';
import 'package:smart_planner/app/modules/home/presentation/bloc/todo_list/todo_list_event.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/controllers/app_state.dart';

class AddNewItemInTodoListBloc extends Bloc<TodoListEvent, AppState>
    implements Disposable {
  final AddItemInListTodo _usecase;
  AddNewItemInTodoListBloc(this._usecase) : super(InitialState()) {
    on<AddNewItemInTodoListEvent>(_onAddNewItemInTodoListEvent);
  }

  _onAddNewItemInTodoListEvent(
      AddNewItemInTodoListEvent event, Emitter<AppState> emit) async {
    emit(ProcessingState());
    final params = Params(event.item, event.groupName);
    final result = await _usecase.call(params);
    emit(result.fold((failure) {
      switch (failure.runtimeType) {
        case EmptyParamsAddTodoListFailure:
          return EmptyParamsAddNewItemState('Os itens não podem está vazios');
        default:
          return AddNewItemInTodoListErrorState('Indisponível no momento');
      }
    }, (r) {
      return SuccessAddNewItemInTodoListState();
    }));
  }

  @override
  void dispose() => close();
}
