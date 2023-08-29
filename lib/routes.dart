import 'package:flutter/material.dart';
// import 'package:routemaster/routemaster.dart';

import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'features/home/home.dart';
import 'features/profil/profil.dart';
import 'features/search/search_page.dart';
import 'models/route_provider.dart';
import 'splash_screen.dart';

const String _homePageLocation = '/simba/home';
const String _profilPageLocation = '/simba/profil';
const String _searchPageLocation = '/simba/search';

class SimbaRouterDelegate extends RouterDelegate<SimbaRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<SimbaRoutePath> {
  SimbaRouterDelegate({required this.simbaState})
      : navigatorKey = GlobalObjectKey<NavigatorState>(simbaState) {
    simbaState.addListener(() {
      notifyListeners();
    });
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  RouterProvider simbaState;

  @override
  void dispose() {
    simbaState.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  SimbaRoutePath get currentConfiguration => simbaState.routePath;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RouterProvider>.value(value: simbaState),
      ],
      child: Selector<RouterProvider, SimbaRoutePath?>(
        selector: (context, routerProvider) => routerProvider.routePath,
        builder: (context, routePath, child) {
          return Navigator(
            key: navigatorKey,
            onPopPage: _handlePopPage,
            pages: [
              const CustomTransitionPage(
                // transitionKey: ValueKey('Home'),
                transitionKey: ValueKey('Auth'),
                // screen: HomePage(),
                screen: SplashScreenWrapper(),
              ),
              if (routePath is SimbaProfilPath)
                const CustomTransitionPage(
                  transitionKey: ValueKey('Profil'),
                  screen: ProfilPage(),
                ),
              if (routePath is SimbaSearchPath)
                const CustomTransitionPage(
                  transitionKey: ValueKey('Search'),
                  screen: SearchPage(),
                ),
            ],
          );
        },
      ),
    );
  }

  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    // _handlePopPage should not be called on the home page because the
    // PopNavigatorRouterDelegateMixin will bubble up the pop to the
    // SystemNavigator if there is only one route in the navigator.
    assert(route.willHandlePopInternally ||
        simbaState.routePath is SimbaSearchPath);
    assert(route.willHandlePopInternally ||
        simbaState.routePath is SimbaProfilPath);

    final bool didPop = route.didPop(result);
    if (didPop) simbaState.routePath = const SimbaHomePath();
    return didPop;
  }

  @override
  Future<void> setNewRoutePath(SimbaRoutePath configuration) {
    simbaState.routePath = configuration;
    return SynchronousFuture<void>(null);
  }
}

@immutable
abstract class SimbaRoutePath {
  const SimbaRoutePath();
}

class SimbaAuthPath extends SimbaRoutePath {
  const SimbaAuthPath();
}

class SimbaHomePath extends SimbaRoutePath {
  const SimbaHomePath();
}

class SimbaProfilPath extends SimbaRoutePath {
  const SimbaProfilPath();
}

class SimbaSearchPath extends SimbaRoutePath {
  const SimbaSearchPath();
}

// TODO: Add Shared Z-Axis transition from search icon to search view page (Motion)

class SimbaRouteInformationParser
    extends RouteInformationParser<SimbaRoutePath> {
  @override
  Future<SimbaRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final url = Uri.parse(routeInformation.location!);

    if (url.path == _searchPageLocation) {
      return SynchronousFuture<SimbaSearchPath>(const SimbaSearchPath());
    }
    if (url.path == _profilPageLocation) {
      return SynchronousFuture<SimbaProfilPath>(const SimbaProfilPath());
    }

    return SynchronousFuture<SimbaHomePath>(const SimbaHomePath());
  }

  @override
  RouteInformation? restoreRouteInformation(SimbaRoutePath configuration) {
    if (configuration is SimbaHomePath) {
      return const RouteInformation(location: _homePageLocation);
    }
    if (configuration is SimbaSearchPath) {
      return const RouteInformation(location: _searchPageLocation);
    }
    if (configuration is SimbaProfilPath) {
      return const RouteInformation(location: _profilPageLocation);
    }
    return null;
  }
}

class CustomTransitionPage extends Page {
  final Widget screen;
  final ValueKey transitionKey;

  const CustomTransitionPage({
    required this.screen,
    required this.transitionKey,
  }) : super(key: transitionKey);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
        settings: this,
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        });
  }
}
