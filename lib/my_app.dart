import 'dart:async';

import 'package:code_hannip/providers/purchase_provider.dart';
import 'package:code_hannip/ui/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_widget_builder.dart';
import 'constants/app_themes.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'routes.dart';
import 'ui/auth/sign_in_screen.dart';
import 'ui/home/home.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key, this.initialization}) : super(key: key);

  final Future<FirebaseApp> initialization;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    var provider = Provider.of<ProviderModel>(context, listen: false);
    provider.initialize();
    super.initState();
  }

  @override
  void dispose() {
    var provider = Provider.of<ProviderModel>(context, listen: false);
    provider.subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProviderRef, __) {
        return AuthWidgetBuilder(
          builder:
              (BuildContext context, AsyncSnapshot<User> userSnapshot) {
            return MaterialApp(
              builder: (BuildContext context, Widget child) {
                final MediaQueryData data = MediaQuery.of(context);
                return MediaQuery(
                  data: data.copyWith(textScaleFactor: 1.0),
                  child: child,
                );
              },
              debugShowCheckedModeBanner: false,
              routes: Routes.routes,
              theme: AppThemes.lightTheme,
              themeMode: themeProviderRef.isDarkModeOn
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: Consumer<AuthProvider>(
                builder: (_, authProviderRef, __) {
                  if (userSnapshot.connectionState == ConnectionState.active) {
                    if (authProviderRef.status == Status.Uninitialized) {
                      return SplashScreen();
                    } else if (userSnapshot.hasData &&
                        authProviderRef.status == Status.Authenticated) {
                      return HomeScreen();
                    } else if (authProviderRef.status ==
                            Status.Authenticating ||
                        authProviderRef.status == Status.Unauthenticated ||
                        authProviderRef.status == Status.Registering) {
                      return SignInScreen();
                    } else {
                      return SplashScreen();
                    }
                  } else {
                    return Material(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
