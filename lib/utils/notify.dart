import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

enum CommonType { error, success, info, warning, none }

class Notify {
  static message(BuildContext context, content,
      {CommonType type,
      Widget subtitle,
      EdgeInsetsGeometry contentPadding,
      Color foreground,
      double elevation = 16,
      bool autoDismiss = true,
      Color buttonColor = Colors.white,
      String buttonTitle = '关闭',
      VoidCallback click,
      Key key}) {
    showSimpleNotification(Text(content),
        subtitle: subtitle,
        trailing: Builder(
            builder: (context) => FlatButton(
                textColor: buttonColor,
                onPressed: () {
                  OverlaySupportEntry.of(context).dismiss();
                  if (click != null) click();
                },
                child: Text(buttonTitle))),
        contentPadding: contentPadding,
        background: _color(type),
        foreground: foreground,
        elevation: elevation,
        autoDismiss: autoDismiss,
        key: key);
  }

  static Color _color(CommonType type) {
    Color color;
    switch (type) {
      case CommonType.success:
        color = Colors.green;
        break;
      case CommonType.warning:
        color = Colors.orange;
        break;
      case CommonType.error:
        color = Colors.red;
        break;
      default:
        color = Colors.blue;
    }
    return color;
  }
}
