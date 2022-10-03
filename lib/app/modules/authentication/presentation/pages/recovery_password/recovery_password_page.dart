import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/core/presentation/widgets/buttons_design.dart';
import 'package:smart_planner/app/core/presentation/widgets/form_desing.dart';
import 'package:smart_planner/app/modules/authentication/presentation/controllers/recovery_password_user_controller/recovery_password_event.dart';
import 'package:smart_planner/app/modules/authentication/presentation/controllers/recovery_password_user_controller/recovery_password_with_email_bloc.dart';

import '../../../../../core/presentation/controllers/app_state.dart';
import '../../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../../core/theme/theme_app.dart';
import '../../../../../core/utils/widgets_utils.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({Key? key}) : super(key: key);

  @override
  State<RecoveryPasswordPage> createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState extends State<RecoveryPasswordPage> {
  final _emailController = TextEditingController();
  final _recoveryController = Modular.get<RecoveryPasswordWithEmailBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: BlocConsumer(
        bloc: _recoveryController,
        listener: (context, state) {
          if (state is SuccessRecoveryState) {
            WidgetUtils.showSnackBar(context, '',
                actionText:
                    'Dentro de alguns segundos você receberá um email de recuperação de senha',
                onTap: () => Modular.to.pop());
          }
        },
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Insira seus dados para recuperar sua Senha',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Insira Seu Email',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              FormsDesign(controller: _emailController),
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
              const SizedBox(
                height: 20,
              ),
              (state is ProcessingState)
                  ? const Center(child: LoadingDesign())
                  : ButtonDesign(
                      text: 'Recuperar senha',
                      action: () {
                        _recoveryController.add(RecoveryPasswordWithEmailEvent(
                          email: _emailController.text,
                        ));
                      })
            ],
          ),
        ),
      ),
    );
  }
}
