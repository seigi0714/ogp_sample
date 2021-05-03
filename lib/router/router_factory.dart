import 'package:flutter/material.dart';
import 'package:flutter_web_router/flutter_web_router.dart';
import 'package:ogp_sample/router/path_constants.dart';
import 'package:ogp_sample/screen/home/home_page.dart';
import 'package:ogp_sample/screen/post/post_page.dart';
import 'package:ogp_sample/screen/user/user_page.dart';
import 'package:provider/provider.dart';

class RouterFactory {
  static WebRouter create() {
    final router = WebRouter();

    router.addRoute(PathConstants.routeHome, _pageBuilder(HomePage()));
    router.addRoute(PathConstants.routeUser, _pageBuilder(UserPage()));
    router.addRoute(PathConstants.routePost, _pageBuilder(PostPage()));

    router.addFilter(LoginVerificationFilter([
      PathConstants.routeHome,
      PathConstants.routeUser,
      PathConstants.routePost,
    ]));

    router.setOnComplete((settings, widget) {
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => widget,
        transitionsBuilder: (_, anim, __, child) {
          return FadeTransition(
            opacity: anim,
            child: child,
          );
        },
      );
    });

    return router;
  }

  /// ページを返すWidgetBuilderを返す
  static WebRouterWidgetBuilder _pageBuilder(Widget widget) {
    return (request) {
      return Provider<WebRequest>.value(
        value: request,
        child: widget,
      );
    };
  }
}

/// ログイン状態をみるFilter
class LoginVerificationFilter implements WebFilter {
  LoginVerificationFilter(this.exclusionRoutes);

  final List<String> exclusionRoutes;

  @override
  Widget execute(WebFilterChain filterChain) {
    final requestPath = Uri.parse(filterChain.settings.name).path;

    // OGPから遷移してきたものを通常のパスにリダイレクトさせる
    if (requestPath.contains('/ogp__')) {
      throw RedirectWebRouterException(
          settings:
              RouteSettings(name: requestPath.replaceFirst('/ogp__', '/')));
    }

    // 除外されたパスなら次のFilterへ
    if (_matchExclusion(filterChain, requestPath)) {
      return filterChain.executeNextFilter();
    }
  }

  /// リクエストパスと除外パスが一致するかを返す
  bool _matchExclusion(WebFilterChain filterChain, String requestPath) {
    for (String route in exclusionRoutes) {
      final request = WebRequest.settings(filterChain.settings, route: route);
      if (request.verify) {
        return true;
      }
    }
    return false;
  }
}
