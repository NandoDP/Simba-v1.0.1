import 'package:flutter/material.dart';

import '../routes.dart';

class RouterProvider with ChangeNotifier {
  RouterProvider(SimbaAuthPath this._routePath);

  SimbaRoutePath _routePath;
  SimbaRoutePath get routePath => _routePath;

  set routePath(SimbaRoutePath? route) {
    if (route != _routePath) {
      _routePath = route!;
      notifyListeners();
    }
  }
}
