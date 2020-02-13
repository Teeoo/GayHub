import 'package:flutter/material.dart' show BuildContext;
import 'package:gayhub/store/model/auth_model.dart';
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, MultiProvider, Provider;

export 'package:provider/provider.dart';

class Store {
  static BuildContext context;
  static of(BuildContext context) {
    Store.context ??= context;
    return context;
  }

  static init({context, child}) {
    return MultiProvider(
      child: child,
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthModel(),
        ),
      ],
    );
  }

  static T value<T>([BuildContext context]) {
    context ??= Store.context;
    return Provider.of<T>(context);
  }
}
