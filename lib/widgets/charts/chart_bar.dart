import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  });

  final double fill;

  @override
  Widget build(BuildContext context) {
    /*
      mediaQuery - это специальный виджет и класс, 
      который хранит информацию о среде (media), в которой отображается твой UI.
      размеры экрана, отступы (safe area);
      ориентация (portrait/landscape);
      системные настройки (например, тёмная/светлая тема);
      коэффициент масштабирования текста (text scale factor).
    */
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
        
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill, // 0...1 (where 0=0%, 1=100%)
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
