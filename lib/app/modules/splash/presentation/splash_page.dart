import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/core/presentation/controllers/app_state.dart';
import 'package:smart_planner/app/core/presentation/widgets/loading_desing.dart';
import 'package:smart_planner/app/core/utils/color_utils.dart';
import 'package:smart_planner/app/core/utils/widgets_utils.dart';
import 'package:smart_planner/app/modules/splash/presentation/controllers/get_user_logged_bloc.dart';
import 'package:smart_planner/app/modules/splash/presentation/controllers/splash_event.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _blocGetUserLogged = Modular.get<GetUserLoggedBloc>();

  @override
  void initState() {
    super.initState();
    _blocGetUserLogged.add(const GetUserLoggedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {
        if (state is SuccessUserLoggedState) {
          Modular.to.pushReplacementNamed('/home/');
        }
        if (state is SuccessUserLoggedLoginState) {
          Modular.to.pushReplacementNamed('/authentication/');
        }
        if (state is NetworkErrorState) {
          WidgetUtils.showOkDialog(
              context, 'Sem Internet', state.message!, 'Reload', () {
            _blocGetUserLogged.add(const GetUserLoggedEvent());
            Modular.to.pop();
          }, permanentDialog: false);
        }
        if (state is ErrorState) {
          WidgetUtils.showOkDialog(context, 'Erro', state.message!, 'Fechar',
              () {
            Modular.to.pop();
          }, permanentDialog: false);
        }
      },
      bloc: _blocGetUserLogged,
      builder: (context, state) => Container(
        color: ColorUtils.primaryColor,
        child: const Center(child: LoadingDesign()),
      ),
    );
  }
}
