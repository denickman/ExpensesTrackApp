import 'package:flutter/material.dart';
import 'package:third_app/widgets/expenses.dart';

// Scheme.fromSeed - Это фабричный конструктор,
// который генерирует целую палитру (ColorScheme) из одного базового цвета (seedColor).

// Что делает:
// Берёт указанный цвет (seedColor).
// По алгоритмам Material Design 3 создаёт гармоничную палитру
// (primary, secondary, tertiary, background, onPrimary, onSurface и т.д.).
// Гарантирует, что все цвета будут сочетаться и иметь правильный контраст для accessibility.

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181),
);

void main() {
  runApp(
    MaterialApp(
      // theme: ThemeData(useMaterial3: true), - already set by default
      // theme: ThemeData().copyWith(useMaterial3: true),
      theme: ThemeData(
        // scaffoldBackgroundColor: Colors.blueAccent.shade200,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),

        cardTheme: const CardThemeData().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),

        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: 
          TextStyle(
            fontWeight: FontWeight.normal, 
            color: kColorScheme.onSecondaryContainer, 
            fontSize: 14
            ),
        )
      ),
      home: Expenses(),
    ),
  );
}
