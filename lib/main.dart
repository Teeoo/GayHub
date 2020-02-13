import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gayhub/pages/index_page.dart';
import 'package:gayhub/pages/login/login_page.dart';
import 'package:gayhub/router/application.dart';
import 'package:gayhub/router/routers.dart';
import 'package:gayhub/store/model/auth_model.dart';
import 'package:gayhub/store/store.dart';
import 'package:gayhub/utils/localStorage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(new App());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class App extends StatefulWidget {
  App() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String _token;
  @override
  void initState() {
    callLoad();
    super.initState();
  }

  Future<void> callLoad() async {
    var data = await LocalStorage.get('token');
    setState(() {
      _token = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (BuildContext context) {
            return AuthModel();
          })
        ],
        child: Consumer<AuthModel>(builder: (context, appProvider, child) {
          final HttpLink httpLink = HttpLink(
            uri: 'https://api.github.com/graphql',
          );

          final AuthLink authLink = AuthLink(
            getToken: () => 'Bearer ${(appProvider.token ?? _token)}',
          );
          print('Bearer ${(appProvider.token ?? _token)}');
          final Link link = authLink.concat(httpLink);
          ValueNotifier<GraphQLClient> client = ValueNotifier(
            GraphQLClient(
              cache: InMemoryCache(),
              link: link,
            ),
          );
          return WillPopScope(
              onWillPop: () => _onWillPop(context),
              child: GraphQLProvider(
                  client: client,
                  child: CacheProvider(
                      child: OverlaySupport(
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'GayHub',
                      theme: ThemeData(
                        primarySwatch: Colors.blue,
                      ),
                      home: (appProvider.token ?? _token) != null
                          ? IndexPage()
                          : LoginPage(),
                      onGenerateRoute: Application.router.generator,
                    ),
                  ))));
        }));
  }

  Future<bool> _onWillPop(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('提示'),
            content: Text('确定退出应用吗?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('再看一会'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('退出'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
