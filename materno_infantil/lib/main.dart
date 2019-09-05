import 'package:flutter/material.dart';
import 'package:materno_infantil/ui/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    supportedLocales: [const Locale('pt', 'BR')],
  ));
}


