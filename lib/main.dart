import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/auth/auth_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/group/group_overview_screen.dart';
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
            return AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: userSnapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : userSnapshot.hasData
                      ? ChatScreen()
                      : AuthScreen(),
            );
          },
        ),
        routes: {
          GroupOverviewScreen.routeName: (ctx) => GroupOverviewScreen(),
        },
      );
  }
}
