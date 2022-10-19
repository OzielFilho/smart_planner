import 'package:smart_planner/app/modules/home/domain/entities/todo_item.dart';

abstract class TodoListEvent {
  const TodoListEvent();
}

class GetTodoListEvent implements TodoListEvent {
  GetTodoListEvent();
}

class AddNewItemInTodoListEvent implements TodoListEvent {
  final TodoItem item;
  final String groupName;

  AddNewItemInTodoListEvent(this.item, this.groupName);
}
