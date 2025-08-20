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
          children: [
            Text(expense.title),
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
                    const Icon(Icons.account_balance_outlined),
                    const SizedBox(width: 8),
                    Text(expense.date.toString()),
                  ]
                ),
              ],

            ),
          ],
        ),
      ),
    );
  }
}
