
import 'package:crypto_currency/logic/Providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of(context);
    // final themeProvider = Provider.of<ThemeProvider>(context);
    final Icon iconSwitcher = Icon(
      themeProvider.isDarkMode
          ? CupertinoIcons.sun_max_fill
          : CupertinoIcons.moon_fill,
    );
    return IconButton(
      onPressed: () {
        themeProvider.toggleTheme();
      },
      icon: iconSwitcher,
    );
  }
}
