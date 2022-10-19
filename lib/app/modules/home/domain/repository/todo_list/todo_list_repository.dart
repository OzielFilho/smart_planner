import 'package:dartz/dartz.dart';
import 'package:smart_planner/app/core/errors/failure.dart';
import 'package:smart_planner/app/modules/home/domain/entities/todo_group_item.dart';

import '../../entities/todo_item.dart';

abstract class TodoListRepository {
  Future<Either<Failure, List<TodoGroupItem>>> getTodoList();
  Future<Either<Failure, String>> addItemInListTodo(
      TodoItem item, String groupName);
}
