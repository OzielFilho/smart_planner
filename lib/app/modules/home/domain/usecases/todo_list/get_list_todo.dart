import 'package:smart_planner/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/core/usecase/usecase.dart';
import 'package:smart_planner/app/modules/home/domain/repository/todo_list/todo_list_repository.dart';

import '../../entities/todo_group_item.dart';

class GetListTodo extends Usecase<List<TodoGroupItem>, NoParams> {
  final TodoListRepository _repository;

  GetListTodo(this._repository);

  @override
  Future<Either<Failure, List<TodoGroupItem>>> call(NoParams? params) async {
    final result = await _repository.getTodoList();
    return result.fold(
        (failure) => left(failure),
        (success) =>
            success.isEmpty ? left(EmptyListTodoFailure()) : right(success));
  }
}
