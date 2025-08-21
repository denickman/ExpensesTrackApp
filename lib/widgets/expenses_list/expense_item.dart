import 'dart:math';
import 'package:flutter/material.dart';
import 'package:third_app/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      /*
      🔹 Что даёт Card
          Фон и тень → автоматически рисуется белая или заданная поверхность 
          с лёгким поднятием (elevation), создаёт эффект отдельного блока.

          Закруглённые углы (shape) → по умолчанию слегка скруглённые, можно кастомизировать.

          Material-эффекты → ripple-эффект при нажатии, если вложить InkWell.

          Автоматическое соответствие Material Design → не надо вручную писать Container с 
          BoxDecoration (тень, бордеры, радиусы).

          но нету padding - internal space 
      */
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child:
            // TEST EXPANDED
            //  Row(
            //       children: [
            //         Expanded(flex: 2, child: Container(height: 50,color: Colors.red)),
            //         Expanded(flex: 1, child: Container(height: 50, color: Colors.blue)),
            //       ],
            //     ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  /*
                    Theme.of(context)
                    Достаёт текущую глобальную тему (ThemeData), которая была задана в 
                    MaterialApp(theme: ThemeData(...)).
                    Внутри Flutter тема хранится в дереве виджетов через InheritedWidget, 
                    и Theme.of(context) — это способ получить её для данного BuildContext.

                    .textTheme
                    Из ThemeData берётся набор стандартных текстовых стилей (TextTheme).
                    В TextTheme есть разные преднастроенные стили: titleLarge, bodyMedium, labelSmall и т.д.
                    Эти стили соответствуют иерархии типографики Material Design 3.

                    .titleLarge
                    Это один конкретный стиль текста из темы (TextStyle).
                    По умолчанию — крупный заголовок (размер, вес шрифта, цвет), 
                    но его можно переопределить в ThemeData.textTheme.
                  */
                  style: Theme.of(context).textTheme.titleLarge, 
                  ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    // Если после переменной идёт что-то ещё (метод, свойство или арифметика),
                    // то нужны фигурные скобки, чтобы Dart понял, где заканчивается переменная и начинается код:
                    // Без {} Dart не поймёт, что .toStringAsFixed(2) — это метод переменной amount
                    // toStringAsFixed 12.45678 => 12.45
                    Text('\$${expense.amount.toStringAsFixed(2)}'),
                    const Spacer(), // это гибкий заполнитель пространства внутри Row, Column или Flex.
                    Row(
                      children: [
                        Icon(categoryIcons[expense.category]),
                        const SizedBox(width: 8),
                        Text(expense.formattedDate),
                      ],
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
