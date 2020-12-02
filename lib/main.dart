import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/providers/auth.dart';
import 'core/viewmodels/message_crud_model.dart';
import 'core/viewmodels/user_crud_model.dart';
import 'locator.dart';
import 'ui/router.dart' as router;
import 'ui/screens/auth/auth_screen.dart';
import 'ui/screens/message/message_screen.dart';
import 'ui/themes/root_theme_builder.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => locator<MessageCRUDModel>(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => locator<UserCRUDModel>(),
        ),
      ],
      child: Consumer<Auth>(
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
                      ? MessageScreen()
                      : AuthScreen();
            },
          ),
          onGenerateRoute: router.Router.generateRoute,
        ),
      ),
    );
  }
}
