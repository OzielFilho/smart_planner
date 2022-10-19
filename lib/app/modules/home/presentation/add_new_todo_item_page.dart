import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/core/presentation/controllers/app_state.dart';
import 'package:smart_planner/app/core/presentation/widgets/buttons_design.dart';
import 'package:smart_planner/app/core/presentation/widgets/form_desing.dart';
import 'package:smart_planner/app/core/utils/color_utils.dart';
import 'package:smart_planner/app/modules/home/infrastructure/models/todo_item_model.dart';
import 'package:smart_planner/app/modules/home/presentation/bloc/todo_list/add_new_item_in_todo_list_bloc.dart';
import 'package:smart_planner/app/modules/home/presentation/bloc/todo_list/get_todo_list_bloc.dart';
import 'package:smart_planner/app/modules/home/presentation/bloc/todo_list/todo_list_event.dart';

import '../../../core/presentation/widgets/loading_desing.dart';
import '../../../core/theme/theme_app.dart';
import '../../../core/utils/widgets_utils.dart';

class AddNewTodoItemPage extends StatefulWidget {
  const AddNewTodoItemPage({super.key});

  @override
  State<AddNewTodoItemPage> createState() => _AddNewTodoItemPageState();
}

class _AddNewTodoItemPageState extends State<AddNewTodoItemPage> {
  final _getTodoListBloc = Modular.get<GetTodoListBloc>();
  final _getAddNewItemInTodoListBloc = Modular.get<AddNewItemInTodoListBloc>();
  final _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();
  final _controllerGroup = TextEditingController();

  List<String> _typesGroups = [];
  String _groupSelected = '';

  @override
  void initState() {
    _typesGroups = _getTodoListBloc.resultList.map((e) => e.nameGroup).toList();
    if (_typesGroups.isNotEmpty) {
      _groupSelected = _typesGroups.first;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              _getTodoListBloc.add(GetTodoListEvent());
              Modular.to.pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text(
          'Nova tarefa',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: BlocConsumer(
          bloc: _getAddNewItemInTodoListBloc,
          listener: (context, state) {
            if (state is NetworkErrorState) {
              WidgetUtils.showOkDialog(
                  context, 'Sem Internet', state.message!, 'Reload', () {},
                  permanentDialog: false);
            }
            if (state is SuccessState) {
              WidgetUtils.showSnackBar(context, 'Criado com Sucesso',
                  actionText: '', onTap: () {});
              //Modular.to.pop();
            }
          },
          builder: (context, AppState state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Título da Tarefa',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormsDesign(
                        controller: _controllerTitle,
                        borderRadius: 20,
                      ),
                    ),
                    Text(
                      'Descrição da Tarefa',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormsDesign(
                        controller: _controllerDescription,
                        borderRadius: 20,
                      ),
                    ),
                    Text(
                      'Grupo da Tarefa',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    _typesGroups.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FormsDesign(
                              controller: _controllerGroup,
                              borderRadius: 20,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                                dropdownColor: ColorUtils.whiteColor,
                                focusColor: ColorUtils.whiteColor,
                                value: _groupSelected,
                                style: Theme.of(context).textTheme.subtitle1,
                                items: _typesGroups
                                    .map<DropdownMenuItem<String>>(
                                        (e) => DropdownMenuItem<String>(
                                              value: e,
                                              child: Text(
                                                e,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(
                                                        color: ColorUtils
                                                            .blackColor),
                                              ),
                                            ))
                                    .toList(),
                                onChanged: (value) {
                                  _groupSelected = value!;
                                  setState(() {});
                                }),
                          ),
                    if (state is ErrorState) ...[
                      AnimatedContainer(
                        duration: const Duration(seconds: 5),
                        curve: Curves.ease,
                        child: Text(
                          state.message!,
                          style: ThemeApp.theme.textTheme.subtitle1,
                        ),
                      )
                    ],
                    (state is ProcessingState)
                        ? const Center(child: LoadingDesign())
                        : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ButtonDesign(
                                text: 'Criar',
                                action: () {
                                  final groupName = _groupSelected.isEmpty
                                      ? _controllerGroup.text
                                      : _groupSelected;
                                  _getAddNewItemInTodoListBloc.add(
                                      AddNewItemInTodoListEvent(
                                          TodoItemModel(
                                              title: _controllerTitle.text,
                                              createAt: DateTime.now(),
                                              description:
                                                  _controllerDescription.text,
                                              group: groupName,
                                              progress: 0),
                                          groupName));
                                }),
                          ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
