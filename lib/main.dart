import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:recipe_ventures/pages/homepage.dart';
import 'package:recipe_ventures/pages/navBar.dart';
import 'package:recipe_ventures/utils/constants.dart';
import 'package:recipe_ventures/theme/themeManager.dart';
import 'package:provider/provider.dart';
import 'package:recipe_ventures/pages/welcomepage.dart';

import 'data/appUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => new ThemeNotifier(), child: Phoenix(child: MyApp())));
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;

  LifecycleEventHandler({this.resumeCallBack});

  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
    }
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<AppUser>.value(value: AppUser.getCurrentUser())
        ],
        child: Consumer<ThemeNotifier>(
          builder: (context, theme, _) => MaterialApp(
            theme: theme.getTheme(),
            home: WelcomePage(),
            // MainPage(),
          ),
        ));
  }
}
