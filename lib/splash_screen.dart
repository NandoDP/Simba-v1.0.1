import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simba/features/home/home.dart';
import 'package:simba/models/user_model.dart';

import 'features/auth/auth_screen.dart';

class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserM?>(context);
    if (user == null) {
      return const AuthenticateScreen();
    } else {
      return const HomePage();
    }
  }
}
