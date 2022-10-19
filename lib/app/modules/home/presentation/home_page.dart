import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/core/presentation/controllers/app_state.dart';
import 'package:smart_planner/app/core/utils/color_utils.dart';
import 'package:smart_planner/app/modules/home/presentation/bloc/todo_list/get_todo_list_bloc.dart';
import 'package:smart_planner/app/modules/home/presentation/bloc/todo_list/todo_list_event.dart';

import '../../../core/presentation/widgets/loading_desing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _blocGetList = Modular.get<GetTodoListBloc>();
  final _controller = ScrollController();
  @override
  void initState() {
    _blocGetList.add(GetTodoListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
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
      backgroundColor: ColorUtils.whiteColor,
      floatingActionButton: InkWell(
        onTap: () => Modular.to.pushNamed('add_new_item'),
        child: const CircleAvatar(
          radius: 30,
          backgroundColor: ColorUtils.primaryColor,
          child: Icon(
            Icons.add,
            size: 30,
            color: ColorUtils.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Suas Tarefas',
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.copyWith(color: ColorUtils.primaryColor),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: ColorUtils.primaryColor,
                          size: 30,
                        )),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: BlocBuilder(
                  builder: (context, AppState state) {
                    if (state is ProcessingState) {
                      return const Center(
                          child: LoadingDesign(
                        color: ColorUtils.primaryColor,
                      ));
                    }
                    if (state is ErrorState) {
                      return Center(
                        child: Text(
                          state.message!,
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView.builder(
                        controller: _controller,
                        shrinkWrap: true,
                        itemCount: _blocGetList.resultList.length,
                        itemBuilder: (context, index) {
                          final item = _blocGetList.resultList[index];
                          return Text(item.nameGroup);
                        },
                      ),
                    );
                  },
                  bloc: _blocGetList,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
