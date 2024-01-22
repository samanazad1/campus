import 'package:campus/view/nav_screens/home_screen/mainScreen.dart';
import 'package:campus/view/z_config/cutom_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily: 'montserrat',
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
                iconColor: MaterialStateProperty.all(Colors.white))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ))),
       supportedLocales: const [
  Locale('en'),
  Locale('ku'),
  Locale('ar'),
],

    home: const MainScreen(),
  ));
}
