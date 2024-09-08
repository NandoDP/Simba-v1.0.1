import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/models/route_provider.dart';
import 'package:simba/routes.dart';
import 'package:simba/theme/pallete.dart';

import 'features/auth/auth_service.dart';
import 'models/post_model.dart';
import 'models/post_service.dart';
import 'models/post_store.dart';
import 'models/user_model.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  SimbaAppState createState() => SimbaAppState();
}

class SimbaAppState extends State<MyApp> {
  final RouterProvider _simbaState = RouterProvider(const SimbaAuthPath());
  final SimbaRouteInformationParser _routeInformationParser =
      SimbaRouteInformationParser();
  late final SimbaRouterDelegate _routerDelegate;

  @override
  void initState() {
    super.initState();
    _routerDelegate = SimbaRouterDelegate(simbaState: _simbaState);
  }

  @override
  void dispose() {
    _routerDelegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var posts = <Post>[];
    return StreamProvider<UserM?>.value(
      value: AuthenticationService().user,
      initialData: null,
      child: StreamProvider<List<Post>>.value(
        value: PostService().posts,
        initialData: const [],
        child: Builder(
          builder: (context) {
            final posts = Provider.of<List<Post>>(context);

            final futures = {
              for (var e in posts)
                if (e.date.compareTo(DateTime.now()) >= 0) e
            };
            final pastes = {
              for (var e in posts)
                if (e.date.compareTo(DateTime.now()) < 0) e
            };

            return MultiProvider(
              providers: [
                ChangeNotifierProvider<PostStore>(
                  create: (_) => PostStore(
                    categories: <String, Set<Post>>{
                      'A venir': futures,
                      'Passées': pastes,
                    },
                  ),
                ),
                ChangeNotifierProvider<StatesStore>(
                  create: (_) => StatesStore(),
                ),
              ],
              child: Selector<StatesStore, ThemeMode>(
                selector: (context, postStore) => postStore.themeMode,
                builder: (context, themeMode, child) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    routeInformationParser: _routeInformationParser,
                    routerDelegate: _routerDelegate,
                    themeMode: themeMode,
                    title: 'Simba',
                    darkTheme: buildSimbaDarkTheme(context),
                    theme: buildSimbaLightTheme(context),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
