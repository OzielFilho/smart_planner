import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/presentation/controllers/app_state.dart';
import '../../../../../core/presentation/widgets/buttons_design.dart';
import '../../../../../core/presentation/widgets/form_desing.dart';
import '../../../../../core/presentation/widgets/loading_desing.dart';
import '../../../../../core/theme/theme_app.dart';
import '../../../../../core/utils/color_utils.dart';
import '../../../../../core/utils/widgets_utils.dart';
import '../../controllers/login_user_controller/login_event.dart';
import '../../controllers/login_user_controller/login_with_email_and_password_bloc.dart';

class LoginAppPage extends StatefulWidget {
  const LoginAppPage({Key? key}) : super(key: key);

  @override
  State<LoginAppPage> createState() => _LoginAppPageState();
}

class _LoginAppPageState extends State<LoginAppPage> {
  final TextEditingController _emailController = TextEditingController();
  final _loginBloc = Modular.get<LoginWithEmailAndPasswordBloc>();
  final TextEditingController _passwordController = TextEditingController();

  bool _visibility = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginWithEmailAndPasswordBloc, AppState>(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is SuccessHomeState) {
          Modular.to.pushReplacementNamed('/home/');
        }

        if (state is NetworkErrorState) {
          WidgetUtils.showOkDialog(
              context, 'Internet Indisponível', state.message!, 'Reload', () {
            Modular.to.pop(context);
          }, permanentDialog: false);
        }
      },
      builder: (context, stateEmail) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Modular.to.pop(),
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
          body: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Insira suas Credenciais',
                            style: ThemeApp.theme.textTheme.headline1),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    'assets/images/login_woman.png'))),
                      ),
                      FormsDesign(
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: ColorUtils.whiteColor,
                        ),
                        suffixIcon: null,
                        title: 'Email',
                        visibility: false,
                        controller: _emailController,
                      ),
                      FormsDesign(
                        prefixIcon: null,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _visibility = !_visibility;
                              });
                            },
                            icon: Icon(
                              _visibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: ColorUtils.whiteColor,
                            )),
                        title: 'Senha',
                        visibility: _visibility,
                        controller: _passwordController,
                      ),
                      if (stateEmail is ErrorState) ...[
                        AnimatedContainer(
                          duration: const Duration(seconds: 5),
                          curve: Curves.ease,
                          child: Text(
                            stateEmail.message!,
                            style: ThemeApp.theme.textTheme.subtitle1,
                          ),
                        )
                      ],
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ButtonDesign(
                            text: 'Entrar',
                            action: () {
                              FocusScope.of(context).unfocus();
                              if (stateEmail is! ProcessingState) {
                                _loginBloc.add(LoginWithEmailAndPasswordEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text));
                              }
                            }),
                      ),
                      if (stateEmail is ProcessingState) ...[
                        const LoadingDesign(),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Esqueceu a senha?',
                            style: ThemeApp.theme.textTheme.overline!.copyWith(
                                color: ColorUtils.whiteColor,
                                fontWeight: FontWeight.normal),
                          ),
                          TextButton(
                              onPressed: () =>
                                  Modular.to.pushNamed('recovery_password'),
                              child: Text(
                                'Clique aqui e recupere',
                                style: ThemeApp.theme.textTheme.caption,
                              )),
                        ],
                      ),
                    ],
                  ))),
        );
      },
    );
  }
}
