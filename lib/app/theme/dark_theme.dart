import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  backgroundColor: Colors.black87,
  dividerTheme: const DividerThemeData(color: Colors.white70),
  textTheme: ThemeData.dark().textTheme.copyWith(
        headline5: ThemeData.dark().textTheme.headline5?.copyWith(
              color: Colors.white60,
              fontSize: 16.0,
            ),
        headline6: ThemeData.dark().textTheme.headline6?.copyWith(
              fontSize: 16.0,
            ),
      ),
);
