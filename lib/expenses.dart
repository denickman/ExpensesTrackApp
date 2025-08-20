import 'package:flutter/material.dart';
import 'package:third_app/expenses_list.dart';
import 'package:third_app/models/expense.dart';
import 'package:third_app/expenses.dart';

class Expenses extends StatefulWidget {
  // constructor
  const Expenses({super.key});

  // state
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 15.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      Column + ListView = баг, если не обернуть правильно.

      Column говорит: «Я хочу занять столько места по вертикали, сколько нужно моим детям».
      ListView говорит: «Я хочу занять бесконечное место по вертикали, потому что у меня скролл».
      В итоге Flutter офигевает: Column хочет узнать высоту ListView, 
      а ListView говорит «я бесконечный» → конфликт → список не отображается.

      Solving: use Expanded, SizedBox
      */
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
