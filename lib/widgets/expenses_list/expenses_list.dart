import 'package:flutter/material.dart';
import 'package:third_app/models/expense.dart';
import 'package:third_app/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {

  const ExpensesList({
    super.key, 
    required this.expenses,
    required this.onRemoveExpense
    });

  final List<Expense> expenses;

  final void Function(Expense expense) onRemoveExpense;


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
      /*
      Dismissible — это виджет, который можно свайпнуть, чтобы удалить.
      Flutter должен знать, какой именно элемент списка был свайпнут, чтобы:
      правильно отрисовать анимацию удаления;
      не перепутать элементы, когда список обновится.
👉    Если не задать key, то Flutter не сможет различить элементы, и поведение может быть багованным 
     (например, удалится не тот элемент или анимация будет странной).
      */
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]), 
        background: Container(
          color: Theme.of(context).colorScheme.error,
          // BE VERY CAREFUL WITH ! OPERATOR - margin!
          // since you can set maring in light mode, but do not set in dark mode you may get crash!
          margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
        onDismissed: (direction) { 
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index])
        ),
      ); 
 
  }
}