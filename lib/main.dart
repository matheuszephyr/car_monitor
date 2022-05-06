import 'package:carmonitor/widgets/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const CarMonitorApp());
}

class CarMonitorApp extends StatelessWidget {
  const CarMonitorApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Monitor',
      theme: ThemeData(
        //colorScheme: ColorScheme(primary: const Color(0xFF000000)),
        //accentColor: const Color(0xFF000000),
        //backgroundColor: const Color(0xFF000000),
        //scaffoldBackgroundColor: const Color(0xFF000000),
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      home: const Home(),
    );
  }
}
