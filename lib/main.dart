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
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  // brightness - если не установить это свойство то kDarkColorScheme сгенерирует палитру относитлеьно light mode
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      // Dark theme
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: const CardThemeData().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer
          ),
        ),
      ),

      // theme: ThemeData(useMaterial3: true), - already set by default
      // theme: ThemeData().copyWith(useMaterial3: true),
      // Default theme
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

        /*
        ➡️ Ты переопределил titleLarge.
        Теперь каждый виджет Text, который использует Theme.of(context).textTheme.titleLarge, 
        будет иметь:
        размер шрифта 14,
        обычный вес,
        цвет onSecondaryContainer.
        */
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 14,
          ),
        ),
      ),
      // themeMode: ThemeMode.system, // themeMode: ThemeMode.system → приложение будет следовать системным настройкам тёмной/светлой темы.
      home: Expenses(),
    ),
  );
}
