import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/modules/home/domain/usecases/todo_list/get_list_todo.dart';
import 'package:smart_planner/app/modules/home/infrastructure/repositories/todo_list/todo_list_repository_impl.dart';
import 'package:smart_planner/app/modules/home/presentation/add_new_todo_item_page.dart';
import 'package:smart_planner/app/modules/home/presentation/bloc/todo_list/add_new_item_in_todo_list_bloc.dart';
import 'package:smart_planner/app/modules/home/presentation/bloc/todo_list/get_todo_list_bloc.dart';

import 'domain/usecases/todo_list/add_item_in_list_todo.dart';
import 'external/todo_list/firebase/todo_list_firebase.dart';
import 'presentation/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => TodoListFirebase(i(), i())),
    Bind((i) => TodoListRepositoryImpl(i(), i())),
    Bind((i) => GetListTodo(i())),
    Bind((i) => GetTodoListBloc(i())),
    Bind((i) => AddItemInListTodo(i())),
    Bind((i) => AddNewItemInTodoListBloc(i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const HomePage()),
    ChildRoute('/add_new_item',
        child: (context, args) => const AddNewTodoItemPage()),
  ];
}
