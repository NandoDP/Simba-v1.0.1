import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simba/firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(kDebugMode ? false : true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  runApp(const MyApp());
}
