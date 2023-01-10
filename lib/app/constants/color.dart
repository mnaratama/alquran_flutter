import 'package:flutter/material.dart';

const appPurple = Color(0xFF431AA1);
const appPurpleDark = Color(0xFF1E0771);
const appPurpleLight = Color(0xFF9345F2);
const appPurpleLight2 = Color(0xFFB9A2D8);
const appWhite = Color(0xFFFAF8FC);
const appOrange = Color(0xFFE6704A);

ThemeData appLight = ThemeData(
    brightness: Brightness.light,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: appPurpleDark),
    primaryColor: appPurple,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(elevation: 4, backgroundColor: appPurple),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: appPurpleDark),
        bodyText2: TextStyle(color: appPurpleDark)),
    listTileTheme: ListTileThemeData(textColor: appPurpleDark),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appPurpleDark
          )
        ),
      ),
      labelColor: appPurpleDark,
      unselectedLabelColor: Colors.grey,
    ));

ThemeData appDark = ThemeData(
    brightness: Brightness.dark,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: appWhite),
    primaryColor: appPurpleLight2,
    scaffoldBackgroundColor: appPurpleDark,
    appBarTheme: AppBarTheme(elevation: 0, backgroundColor: appPurpleDark),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: appWhite),
        bodyText2: TextStyle(color: appWhite)),
    listTileTheme: ListTileThemeData(textColor: appWhite),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: appWhite
            )
        ),
      ),
      labelColor: appWhite,
      unselectedLabelColor: Colors.grey,
    ));