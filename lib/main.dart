import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:code_hannip/providers/purchase_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'my_app.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';

Future<void> main() async {
  InAppPurchaseConnection.enablePendingPurchases();
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider<ProviderModel>( // for purchase
            create: (context) => ProviderModel(),
          ),
        ],
        child: MyApp(),
      ),
    );
  });


}
