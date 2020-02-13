import 'package:fluro/fluro.dart';
import 'package:gayhub/pages/home_page.dart';
import 'package:gayhub/pages/index_page.dart';

class Routes {
  static void configureRoutes(Router router) {
    Map<String, Handler> handlers = {
      '/': Handler(
          handlerFunc: (_, Map<String, List<String>> params) => IndexPage()),
      '/home': Handler(
          handlerFunc: (_, Map<String, List<String>> params) => HomePage()),
    };

    handlers.forEach((String path, Handler handler) {
      router.define(path, handler: handler);
    });

    router.notFoundHandler =
        new Handler(handlerFunc: (_, Map<String, List<String>> params) {
      print('错误路由');
      return;
    });
  }
}
