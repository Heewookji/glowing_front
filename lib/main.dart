import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glowing_front/providers/firebase_auth_provider.dart';
import 'package:provider/provider.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/group/group_overview_screen.dart';
import 'themes/root_theme_builder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FirebaseAuthProvider(),
        ),
      ],
      child: Consumer<FirebaseAuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Glowing',
          debugShowCheckedModeBanner: false,
          theme: RootThemeBuilder.build(),
          home: StreamBuilder(
            stream: auth.authStateChanges(),
            builder: (ctx, userSnapshot) {
              return userSnapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : userSnapshot.hasData
                      ? ChatScreen()
                      : AuthScreen();
            },
          ),
          routes: {
            GroupOverviewScreen.routeName: (ctx) => GroupOverviewScreen(),
          },
        ),
      ),
    );
  }
}
