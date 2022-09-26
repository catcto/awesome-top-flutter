import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  backgroundColor: Colors.white70,
  dividerTheme: const DividerThemeData(color: Colors.black12),
  textTheme: ThemeData.light().textTheme.copyWith(
        headline5: ThemeData.light().textTheme.headline5?.copyWith(
              color: Colors.black45,
              fontSize: 16.0,
            ),
        headline6: ThemeData.light().textTheme.headline6?.copyWith(
              fontSize: 16.0,
            ),
      ),
);
