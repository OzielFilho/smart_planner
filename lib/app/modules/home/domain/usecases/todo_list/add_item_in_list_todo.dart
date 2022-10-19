import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_planner/app/modules/home/domain/entities/todo_item.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../repository/todo_list/todo_list_repository.dart';

class AddItemInListTodo extends Usecase<void, Params> {
  final TodoListRepository _repository;

  AddItemInListTodo(this._repository);

  @override
  Future<Either<Failure, void>> call(Params? params) async {
    if (params!.item.title.isEmpty ||
        params.item.description.isEmpty ||
        params.groupName.isEmpty) {
      return left(EmptyParamsAddTodoListFailure());
    }

    return await _repository.addItemInListTodo(params.item, params.groupName);
  }
}

class Params extends Equatable {
  final TodoItem item;
  final String groupName;

  const Params(this.item, this.groupName);
  @override
  List<Object?> get props => [item, groupName];
}
