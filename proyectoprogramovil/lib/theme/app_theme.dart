import 'package:flutter/material.dart';

class AppTheme {
  static final Color primaryCoplor = Colors.blue.shade700;

  static final ThemeData lightSolidTheme = ThemeData(
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(seedColor: primaryCoplor),

    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 25, color: Colors.white),
      backgroundColor: primaryCoplor,
      foregroundColor: Colors.white,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: primaryCoplor,
      indicatorColor: Colors.blue.shade400,
      iconTheme: WidgetStateProperty.fromMap({
        WidgetState.selected: IconThemeData(color: Colors.white),
        WidgetState.any: IconThemeData(color: Colors.white),
      }),
      labelTextStyle: WidgetStateProperty.fromMap({
        WidgetState.selected: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        WidgetState.any: TextStyle(color: Colors.white),
      }),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryCoplor,
      foregroundColor: Colors.white,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        backgroundColor: WidgetStateColor.fromMap({
          WidgetState.disabled: Colors.grey.shade400,
          WidgetState.any: primaryCoplor,
        }),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primaryCoplor),
      labelStyle: TextStyle(color: Colors.grey.shade700),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade500),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryCoplor),
      ),
    ),

    tabBarTheme: TabBarThemeData(
      labelColor: Colors.white,
      indicatorColor: Colors.white,
      unselectedLabelColor: Colors.white,
    ),
  );

  static final ThemeData lightTheme = lightSolidTheme.copyWith(
    appBarTheme: AppBarTheme(foregroundColor: Colors.grey.shade900),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: primaryCoplor,
      iconTheme: WidgetStateProperty.fromMap({
        WidgetState.selected: IconThemeData(color: Colors.white),
        WidgetState.any: IconThemeData(color: Colors.grey.shade600),
      }),
      labelTextStyle: WidgetStateProperty.fromMap({
        WidgetState.selected: TextStyle(
          color: primaryCoplor,
          fontWeight: FontWeight.bold,
        ),
        WidgetState.any: TextStyle(color: Colors.grey.shade600),
      }),
    ),

    tabBarTheme: TabBarThemeData(
      labelColor: primaryCoplor,
      indicatorColor: primaryCoplor,
      unselectedLabelColor: Colors.grey.shade800,
    ),
  );
}
