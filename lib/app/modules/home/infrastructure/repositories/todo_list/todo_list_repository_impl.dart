import 'package:smart_planner/app/core/services/network_service.dart';
import 'package:smart_planner/app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/modules/home/domain/entities/todo_item.dart';
import 'package:smart_planner/app/modules/home/domain/repository/todo_list/todo_list_repository.dart';
import 'package:smart_planner/app/modules/home/infrastructure/datasources/todo_list/todo_list_datasource.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../models/todo_group_item_model.dart';

class TodoListRepositoryImpl implements TodoListRepository {
  final TodoListDatasource _datasource;
  final NetworkService _networkService;

  TodoListRepositoryImpl(this._datasource, this._networkService);

  @override
  Future<Either<Failure, List<TodoGroupItemModel>>> getTodoList() async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await _datasource.getTodoList();
      return right(result);
    } on TodoListException {
      return left(TodoListFailure());
    } catch (e) {
      return left(TodoListFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addItemInListTodo(
      TodoItem item, String groupName) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await _datasource.addItemInListTodo(item, groupName);
      return right(result);
    } on TodoListException {
      return left(AddNewItemInTodoListFailure());
    } catch (e) {
      return left(AddNewItemInTodoListFailure());
    }
  }
}
