import 'color_utils.dart';
import 'package:flutter/material.dart';

import '../theme/theme_app.dart';

class WidgetUtils {
  static showSnackBar(BuildContext context, String title,
      {required String? actionText, required VoidCallback? onTap}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      action: SnackBarAction(label: actionText!, onPressed: onTap!),
    ));
  }

  static showOkDialog(BuildContext context, String title, String message,
      String okButton, void Function() onOkPressed,
      {bool permanentDialog = true, Widget? content}) {
    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
          barrierDismissible: permanentDialog,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                backgroundColor: ColorUtils.blackColor,
                title: Text(title, style: ThemeApp.theme.textTheme.headline1),
                content: Builder(
                  builder: (context) {
                    var height = MediaQuery.of(context).size.height;
                    var width = MediaQuery.of(context).size.width;
                    return content != null
                        ? SizedBox(
                            width: width,
                            height: height * 0.145,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(message,
                                    style: ThemeApp.theme.textTheme.subtitle1),
                                const SizedBox(
                                  height: 15,
                                ),
                                content,
                              ],
                            ),
                          )
                        : Text(message,
                            style: ThemeApp.theme.textTheme.subtitle1);
                  },
                ),
                actions: [
                  TextButton(
                      onPressed: onOkPressed,
                      child: Text(okButton,
                          style: ThemeApp.theme.textTheme.subtitle1))
                ]);
          });
    });
  }

  static showBottomSheetCustom(BuildContext context, String title,
      Widget? content, String okButton, void Function() onOkPressed,
      {bool permanentDialog = true}) {
    Future.delayed(const Duration(milliseconds: 500), () {
      return showBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Column(
            children: [
              Text(title, style: ThemeApp.theme.textTheme.headline1),
              TextButton(
                  onPressed: onOkPressed,
                  child:
                      Text(okButton, style: ThemeApp.theme.textTheme.subtitle1))
            ],
          );
        },
      );
    });
  }
}
