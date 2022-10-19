import 'package:smart_planner/app/modules/home/domain/entities/todo_item.dart';

class TodoItemModel extends TodoItem {
  TodoItemModel(
      {required super.title,
      required super.description,
      required super.group,
      required super.progress,
      required super.createAt});

  factory TodoItemModel.fromMap(Map<String, dynamic> document) => TodoItemModel(
      title: document['title'],
      description: document['description'],
      group: document['group'],
      progress: document['progress'],
      createAt: DateTime.fromMicrosecondsSinceEpoch(
          document['createAt'].microsecondsSinceEpoch));

  factory TodoItemModel.fromTodoItem(TodoItem todoItem) {
    return TodoItemModel(
        title: todoItem.title,
        description: todoItem.description,
        group: todoItem.group,
        progress: todoItem.progress,
        createAt: todoItem.createAt);
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'group': group,
        'progress': progress,
        'createAt': createAt,
      };
}
