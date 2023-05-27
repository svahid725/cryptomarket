
import 'package:crypto_currency/logic/Providers/crypto_data_provider.dart';
import 'package:crypto_currency/logic/Providers/marketview_provider.dart';
import 'package:crypto_currency/logic/Providers/theme_provider.dart';
import 'package:crypto_currency/logic/Providers/user_data_provider.dart';
import 'package:crypto_currency/presentation/Ui/signup_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CryptoDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MarketViewProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          debugShowCheckedModeBanner: false,
          locale: const Locale('en', ''),
          title: 'Localizations Sample App',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('fa', ''), // Farsi - Persian
          ],
          home: const Directionality(
            textDirection: TextDirection.ltr,
            child: SignUpScreen(),
          ),
        );
      },
    );
  }
}
