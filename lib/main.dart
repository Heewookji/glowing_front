import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glowing_front/core/services/auth/firebase_auth_service.dart';
import 'package:glowing_front/view/themes/root_theme_builder.dart';
import 'locator.dart';
import 'view/router.dart' as router;
import 'view/screens/auth/auth_screen.dart';
import 'view/screens/tab/main/main_tab_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //가로모드 금지
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glowing',
      debugShowCheckedModeBanner: false,
      theme: RootThemeBuilder.build(),
      home: StreamBuilder(
        stream: getIt<FirebaseAuthService>().authStateChanges(),
        builder: (ctx, userSnapshot) {
          return userSnapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : userSnapshot.hasData
                  ? MainTabScreen()
                  : AuthScreen();
        },
      ),
      routes: router.Router.routes,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
