import 'package:flutter/material.dart';
import 'package:to_do_list2/my_app.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 105, 159, 203));

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData().copyWith(
      colorScheme: kColorScheme,
      bottomAppBarTheme: BottomAppBarTheme().copyWith(
        color: kColorScheme.primary,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: kColorScheme.primary,
        textTheme: ButtonTextTheme.primary,
      ),
    ),
    home: MyApp(),
  ));
}