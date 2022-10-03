import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/core/utils/color_utils.dart';

import '../../../../core/presentation/widgets/buttons_design.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Material(
            color: Colors.transparent,
            elevation: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          ColorUtils.primaryColor.withOpacity(0.5),
                          BlendMode.lighten),
                      image: const AssetImage(
                          'assets/images/authentication_image.png'))),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SMART PLANNER',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  'Seu Aplicativo de organização das atividades estudantis',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonDesign(
                      action: () => Modular.to.pushNamed('login'),
                      text: 'ENTRAR NO APP',
                    ),
                    ButtonDesign(
                      action: () => Modular.to.pushNamed('create_account'),
                      text: 'CADASTRAR CONTA',
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
