import 'package:smart_planner/app/modules/home/infrastructure/models/todo_item_model.dart';

import '../../domain/entities/todo_group_item.dart';

class TodoGroupItemModel extends TodoGroupItem {
  TodoGroupItemModel(
      {required super.itens,
      required super.nameGroup,
      required super.createdAt});

  factory TodoGroupItemModel.fromMap(Map<String, dynamic> document) {
    List itens = document['itens'];

    TodoGroupItemModel todoGroupItemModel = TodoGroupItemModel(
        itens: itens.map((e) {
          return TodoItemModel(
              createAt: DateTime.fromMicrosecondsSinceEpoch(
                  e['createAt'].microsecondsSinceEpoch),
              description: e['description'],
              group: e['group'],
              progress: e['progress'],
              title: e['title']);
        }).toList(),
        nameGroup: document['nameGroup'],
        createdAt: DateTime.fromMicrosecondsSinceEpoch(
            document['createdAt'].microsecondsSinceEpoch));
    return todoGroupItemModel;
  }

  Map<String, dynamic> toJson() {
    return {
      'itens':
          itens.map((e) => TodoItemModel.fromTodoItem(e).toJson()).toList(),
      'nameGroup': nameGroup,
      'createdAt': createdAt,
    };
  }
}
