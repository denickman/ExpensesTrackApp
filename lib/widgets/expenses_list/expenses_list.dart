import 'package:flutter/material.dart';
import 'package:third_app/models/expense.dart';
import 'package:third_app/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {

  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;


  @override
  Widget build(BuildContext context) {
    return
   // Если ты используешь обычный ListView(children: [...]), Flutter создаст все элементы сразу.
   // Поэтому ListView.builder = ленивая загрузка, аналог LazyVStack в SwiftUI.


    // ListView - скроллируемый список, он сам умеет прокручиваться.
    // работает лениво, создаёт элементы только тогда, 
    // когда они попадают в зону видимости (аналог LazyVStack в SwiftUI).
     ListView.builder(
      // itemCount - количество элементов в списке. 
      // Если его не указать, список будет бесконечным (⚠️ надо быть осторожным).

      // itemBuilder — функция, которая вызывается Flutter’ом для каждого элемента, 
      // когда он появляется в зоне видимости.
      itemCount: expenses.length, 
      itemBuilder: (ctx, index) => ExpenseItem(expenses[index]),
      ); 
 
  }
}