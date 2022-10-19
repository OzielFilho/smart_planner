import 'todo_item.dart';

class TodoGroupItem {
  List<TodoItem> itens;
  final String nameGroup;
  final DateTime createdAt;

  TodoGroupItem(
      {required this.itens, required this.nameGroup, required this.createdAt});
}
