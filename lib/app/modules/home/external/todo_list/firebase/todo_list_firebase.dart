import 'package:smart_planner/app/core/services/firebase_auth_service.dart';
import 'package:smart_planner/app/core/services/firebase_store_service.dart';
import 'package:smart_planner/app/modules/home/domain/entities/todo_item.dart';
import 'package:smart_planner/app/modules/home/infrastructure/datasources/todo_list/todo_list_datasource.dart';
import 'package:collection/collection.dart';
import '../../../infrastructure/models/todo_group_item_model.dart';

class TodoListFirebase implements TodoListDatasource {
  final FirebaseAuthService _authService;
  final FirebaseStoreService _storeService;

  TodoListFirebase(this._authService, this._storeService);

  @override
  Future<List<TodoGroupItemModel>> getTodoList() async {
    try {
      if (!await _storeService.existDocument(
          'todo_list', _authService.getUserId!)) {
        return [];
      }
      final result =
          await _storeService.getDocument('todo_list', _authService.getUserId!);
      List todoList = result!['todoList'];
      final listTodo =
          todoList.map((e) => TodoGroupItemModel.fromMap(e)).toList();
      return listTodo;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<String> addItemInListTodo(TodoItem item, String groupName) async {
    try {
      if (!await _storeService.existDocument(
          'todo_list', _authService.getUserId!)) {
        await _storeService.createDocument(
            {'todoList': []}, 'todo_list', _authService.getUserId!);
      }
      final document =
          await _storeService.getDocument('todo_list', _authService.getUserId!);
      List todoList = document!['todoList'];
      List<TodoGroupItemModel> listTodo = todoList.isNotEmpty
          ? todoList.map((e) {
              return TodoGroupItemModel.fromMap(e);
            }).toList()
          : [];

      if (listTodo.isEmpty) {
        listTodo.add(TodoGroupItemModel(
            itens: [item], nameGroup: groupName, createdAt: DateTime.now()));
        await _storeService.updateDocument(
            {'todoList': listTodo.map((e) => e.toJson()).toList()},
            'todo_list',
            _authService.getUserId!);
        return 'Sucesso';
      }
      TodoGroupItemModel? group = listTodo
          .firstWhereOrNull((element) => element.nameGroup == groupName);
      if (group == null) {
        listTodo.add(TodoGroupItemModel(
            createdAt: DateTime.now(), itens: [item], nameGroup: groupName));
        await _storeService.updateDocument(
            {'todoList': listTodo.map((e) => e.toJson()).toList()},
            'todo_list',
            _authService.getUserId!);
        return 'Sucesso';
      }
      if (group.itens.isEmpty) {
        group.itens.add(item);
        await _storeService.updateDocument(
            {'todoList': listTodo.map((e) => e.toJson()).toList()},
            'todo_list',
            _authService.getUserId!);
        return 'Sucesso';
      }
      if (group.itens.isNotEmpty) {
        group.itens.add(item);
        await _storeService.updateDocument(
            {'todoList': listTodo.map((e) => e.toJson()).toList()},
            'todo_list',
            _authService.getUserId!);
        return 'Sucesso';
      }

      return '';
    } catch (e) {
      return 'Error $e';
    }
  }
}
