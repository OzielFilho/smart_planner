import '../../../domain/entities/todo_item.dart';
import '../../models/todo_group_item_model.dart';

abstract class TodoListDatasource {
  Future<List<TodoGroupItemModel>> getTodoList();
  Future<String> addItemInListTodo(TodoItem item, String groupName);
}
