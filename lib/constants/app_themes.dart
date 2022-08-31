import 'package:flutter/material.dart';

import 'app_font_family.dart';

class AppThemes {
  AppThemes._();

  //constants color range for light theme
  static const Color _primaryColor = Color(0xFFFFA825);
  static const Color _secondaryColor = Color(0xFFBDCCD9);
  static const Color _backgroundColor = Color(0xFFFFFFFF);
  static const Color _surfaceColor = Color(0xFFDEDEDE);
  static const Color _errorColor = Color(0xFFF25C4D);
  static const Color _onPrimaryColor = Color(0xFFFFFFFF);
  static const Color _onSecondaryColor = Color(0xFFFFFFFF);
  static const Color _onBackgroundColor = Color(0xFF343434);
  static const Color _onSurfaceColor = Color(0xFFBDBDBD);
  static const Color _onError = Color(0xFFFFFFFF);
  static const Color _PrimaryContainer = Color(0xFFFFEFD7);
  static const Color _onPrimaryContainer = Color(0xFF343434);
  static const Color _secondaryContainer = Color(0xFFE4EBF1);
  static const Color _onSecondaryContainer = Color(0xFF343434);
  static const Color _errorContainer = Color(0xFFFFBFB9);
  static const Color _onErrorContainer = Color(0xFFF25C4D);

  //text theme for light theme
  static final TextStyle _titleLarge_Onb =
  TextStyle(fontFamily:AppFontFamily.YANGJIN, fontSize: 22.0, fontWeight: FontWeight.w400, height: 1.5, color: _onBackgroundColor);
  static final TextStyle _titleMedium_Onb =
  TextStyle(fontFamily:AppFontFamily.NEXON, fontSize: 18.0, fontWeight: FontWeight.w500, height: 1.5, color: _onBackgroundColor);
  static final TextStyle _titleMedium_Onc =
  TextStyle(fontFamily:AppFontFamily.NEXON, fontSize: 18.0, fontWeight: FontWeight.w500, height: 1.5, color: _onPrimaryColor);
  static final TextStyle _titleMedium_Secondary =
  TextStyle(fontFamily:AppFontFamily.NEXON, fontSize: 18.0, fontWeight: FontWeight.w500, height: 1.5, color: _secondaryColor);
  static final TextStyle _titleSmall_Primary =
  TextStyle(fontFamily:AppFontFamily.YANGJIN, fontSize: 14.0, fontWeight: FontWeight.w400, height: 1.4, color: _primaryColor);
  static final TextStyle _bodyLarge_Onb=
  TextStyle(fontFamily: AppFontFamily.NEXON, fontSize: 18.0, fontWeight: FontWeight.w400, height: 1.5, color: _onBackgroundColor);
  static final TextStyle _bodyMedium_Primary =
  TextStyle(fontFamily: AppFontFamily.NEXON, fontSize: 16.0, fontWeight: FontWeight.w400, height: 1.5, color: _primaryColor);
  static final TextStyle _bodyMedium_Onb =
  TextStyle(fontFamily: AppFontFamily.NEXON, fontSize: 16.0, fontWeight: FontWeight.w400, height: 1.5, color: _onBackgroundColor);
  static final TextStyle _bodyMedium_Surface=
  TextStyle(fontFamily: AppFontFamily.YANGJIN, fontSize: 16.0, fontWeight: FontWeight.w400, height: 1.5, color: _surfaceColor);
  static final TextStyle _bodyMedium_Error=
  TextStyle(fontFamily: AppFontFamily.NEXON, fontSize: 16.0, fontWeight: FontWeight.w400, height: 1.5, color: _errorColor);
  static final TextStyle _bodyMedium_Onc=
  TextStyle(fontFamily: AppFontFamily.NEXON, fontSize: 16.0, fontWeight: FontWeight.w400, height: 1.5, color: _onPrimaryColor);
  static final TextStyle _bodySmall_Primary =
  TextStyle(fontFamily: AppFontFamily.NEXON, fontSize: 14.0, fontWeight: FontWeight.w700, height: 1.2, color: _primaryColor);
  static final TextStyle _bodySmall_Onc =
  TextStyle(fontFamily: AppFontFamily.NEXON, fontSize: 14.0, fontWeight: FontWeight.w700, height: 1.2, color: _onPrimaryColor);
  static final TextStyle _labelMedium_Onb =
  TextStyle(fontFamily: AppFontFamily.NEXON, fontSize: 12.0, fontWeight: FontWeight.w400, height: 1.5, color: _onBackgroundColor);
  static final TextStyle _labelSmall_Onb =
  TextStyle(fontFamily: AppFontFamily.SOURCE, fontSize: 16.0, fontWeight: FontWeight.w400, height: 1.5, letterSpacing: 0.8, color: _onBackgroundColor);


  static final TextTheme _textTheme = TextTheme(
    displayLarge: _titleLarge_Onb,
    displayMedium: _titleMedium_Onb,
    displaySmall: _titleMedium_Onc,
    headlineLarge: _titleMedium_Secondary,
    headlineMedium: _titleSmall_Primary,
    headlineSmall: _bodyLarge_Onb,
    titleLarge: _bodyMedium_Primary,
    titleMedium: _bodyMedium_Onb,
    titleSmall: _bodyMedium_Surface,
    bodyLarge: _bodyMedium_Error,
    bodyMedium: _bodyMedium_Onc,
    bodySmall: _bodySmall_Primary ,
    labelLarge: _bodySmall_Onc,
    labelMedium: _labelMedium_Onb,
    labelSmall: _labelSmall_Onb,
  );

  //the light theme
  static final ThemeData lightTheme = ThemeData(
    fontFamily: AppFontFamily.NEXON,
    scaffoldBackgroundColor: _backgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryColor,
        elevation: 3.0
    ),
    appBarTheme: AppBarTheme(
      color: _surfaceColor,
      iconTheme: IconThemeData(color: _primaryColor),
      textTheme: _textTheme,
    ),
    colorScheme: ColorScheme.light(
        primary: _primaryColor,
        secondary: _secondaryColor,
        background: _backgroundColor,
        surface: _surfaceColor,
        error: _errorColor,
        onPrimary: _onPrimaryColor,
        onSecondary: _onSecondaryColor,
        onBackground: _onBackgroundColor,
        onSurface: _onSurfaceColor,
        onError: _onError,
        primaryVariant: _primaryColor,
        secondaryVariant: _secondaryColor,
        primaryContainer: _PrimaryContainer,
        onPrimaryContainer: _onPrimaryContainer,
        secondaryContainer: _secondaryContainer,
        onSecondaryContainer: _onSecondaryContainer,
        errorContainer: _errorContainer,
        onErrorContainer: _onErrorContainer,
        brightness: Brightness.light
    ),
    snackBarTheme: SnackBarThemeData(backgroundColor: _errorColor),
    iconTheme: IconThemeData(color: _primaryColor, size: 24.0),
    popupMenuTheme: PopupMenuThemeData(color: _onSurfaceColor),
    textTheme: _textTheme,
    buttonTheme: ButtonThemeData(
      buttonColor: _primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    unselectedWidgetColor: Colors.grey,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: _surfaceColor,
        labelStyle: TextStyle(
          color: _onPrimaryColor,
        )),
    dialogTheme: DialogTheme(
      shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      titleTextStyle: _titleLarge_Onb,
      contentTextStyle: _bodyMedium_Onb,
    ),
    cardTheme: CardTheme(
        margin: EdgeInsets.all(4.0),
        elevation: 2.0
    ),
    tabBarTheme: TabBarTheme(
      labelColor: _primaryColor,
      unselectedLabelColor: Colors.grey,
      indicator: ShapeDecoration(
        shape: UnderlineInputBorder(
            borderSide: BorderSide(color: _primaryColor, width: 3.0, style: BorderStyle.solid)),
      ),
      labelStyle: _bodySmall_Primary ,
      unselectedLabelStyle: _bodySmall_Primary ,
    ),
  );
}