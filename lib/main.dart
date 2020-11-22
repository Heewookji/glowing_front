import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/study/group_overview_screen.dart';
import 'themes/root_theme_builder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e, trace) {
      print(trace);
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error)
      return null;
    else if (!_initialized)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return MaterialApp(
        title: 'Glowing',
        debugShowCheckedModeBanner: false,
        theme: RootThemeBuilder.build(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (userSnapshot.hasData) return GroupOverviewScreen();
            return AuthScreen();
          },
        ),
        routes: {
          GroupOverviewScreen.routeName: (ctx) => GroupOverviewScreen(),
        },
      );
  }
}
