import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/core/presentation/widgets/buttons_design.dart';
import 'package:smart_planner/app/core/presentation/widgets/form_desing.dart';
import 'package:smart_planner/app/core/presentation/widgets/loading_desing.dart';
import 'package:smart_planner/app/core/utils/color_utils.dart';
import 'package:smart_planner/app/core/utils/widgets_utils.dart';
import 'package:smart_planner/app/modules/authentication/presentation/controllers/create_account_controller/create_account_event.dart';
import 'package:smart_planner/app/modules/authentication/presentation/controllers/create_account_controller/create_account_with_email_and_password_bloc.dart';

import '../../../../../core/presentation/controllers/app_state.dart';
import '../../../../../core/presentation/widgets/image_get_design.dart';
import '../../../../../core/theme/theme_app.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _controllerName = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerPasswordConfirme = TextEditingController();

  final _blocCreateAccount =
      Modular.get<CreateAccountWithEmailAndPasswordBloc>();

  _clearControllers() {
    _controllerName.clear();
    _controllerEmail.clear();
    _controllerPassword.clear();
    _controllerPasswordConfirme.clear();
  }

  bool _visibilityPassword = true;

  late File _image;

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
        listener: (context, state) {
          if (state is SuccessCreateAccountState) {
            _clearControllers();
            WidgetUtils.showSnackBar(context, '',
                actionText: 'Usuário Criado com Sucesso!',
                onTap: () => Modular.to.pop());
            Modular.to.pop();
          }
        },
        bloc: _blocCreateAccount,
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crie sua conta',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  'Insira suas credenciais',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                    alignment: Alignment.center, child: ImageGetDesign()),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Seu Nome',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: ColorUtils.whiteColor),
                ),
                FormsDesign(controller: _controllerName),
                Text(
                  'Seu Email',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: ColorUtils.whiteColor),
                ),
                FormsDesign(controller: _controllerEmail),
                Text(
                  'Senha',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: ColorUtils.whiteColor),
                ),
                FormsDesign(
                  controller: _controllerPassword,
                  visibility: _visibilityPassword,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _visibilityPassword = !_visibilityPassword;
                        });
                      },
                      icon: Icon(
                        _visibilityPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: ColorUtils.whiteColor,
                      )),
                ),
                Text(
                  'Repita a Senha',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: ColorUtils.whiteColor),
                ),
                FormsDesign(
                  controller: _controllerPasswordConfirme,
                  visibility: _visibilityPassword,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _visibilityPassword = !_visibilityPassword;
                        });
                      },
                      icon: Icon(
                        _visibilityPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: ColorUtils.whiteColor,
                      )),
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
                const SizedBox(
                  height: 20,
                ),
                (state is ProcessingState)
                    ? const Center(child: LoadingDesign())
                    : ButtonDesign(
                        text: 'Criar Conta',
                        action: () {
                          _blocCreateAccount.add(
                              CreateAccountWithEmailAndPasswordEvent(
                                  email: _controllerEmail.text,
                                  password: _controllerPassword.text,
                                  passwordConfirme:
                                      _controllerPasswordConfirme.text,
                                  name: _controllerName.text,
                                  photo: ''));
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
