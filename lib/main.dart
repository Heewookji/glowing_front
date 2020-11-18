import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'screens/auth/login_screen.dart';
import 'screens/study/group_overview_screen.dart';
import 'themes/root_theme_builder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Glowing',
          debugShowCheckedModeBanner: false,
          theme: RootThemeBuilder.build(),
          home: auth.isAuth ? GroupOverviewScreen() : LoginScreen(),
          routes: {
            GroupOverviewScreen.routeName: (ctx) => GroupOverviewScreen(),
          },
        ),
      ),
    );
  }
}
