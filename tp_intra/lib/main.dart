import 'package:flutter/material.dart';

import 'views/tableau_periodique_vue.dart';

void main() {
  runApp(const TableauPeriodiqueApp());
}

class TableauPeriodiqueApp extends StatelessWidget {
  const TableauPeriodiqueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAL tableau périodique',
      theme: ThemeData(
        useMaterial3: true,

        // slider
        sliderTheme: const SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
        ),

        // color scheme sombre
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const TableauPeriodiqueVue(),
    );
  }
}
