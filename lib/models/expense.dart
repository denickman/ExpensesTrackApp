import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
final uuid = Uuid();

/*
.values → список (List) всех значений перечисления, в порядке их объявления.
.name → строковое имя константы (как она записана в коде).
.index → порядковый номер (начиная с 0).
*/
enum Category {
  food, travel, leisure, work 
}

// Map - Dictionary
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  /*
  После двоеточия (:) идёт initializer list — список инициализации.
  Здесь выполняется код до того, как объект будет полностью создан. 

  Библиотека uuid поддерживает несколько алгоритмов генерации UUID:
    v1 — на основе времени и MAC-адреса устройства.
    v3 — на основе хэша (MD5).
    v4 — случайный UUID, генерируется случайным образом.
    v5 — на основе хэша (SHA-1).
  */

  final String id;
  final String title;
  final double amount; 
  final DateTime date;
  final Category category;

// get — это тоже метод, просто вызывается как свойство.
// А значит, если у него всего одно выражение, можно спокойно использовать стрелочную семантику =>.
  String get formattedDate {
    return formatter.format(date);
  }

  String get formattedDateAlternative => formatter.format(date);
}


class ExpenseBucket {

  const ExpenseBucket({
    required this.category, 
    required this.expenses
  });

// define your own custom constructor (convinience init)
// allExpenses → это вспомогательный параметр, который используется только внутри конструктора 
// (чтобы отфильтровать список), и не хранится в классе как свойство.
// Поэтому его объявляем как обычный параметр без this..

//: expenses = ... ?
// Это так называемый initializer list — блок, который выполняется до конструктора и 
// позволяет проинициализировать final поля.

  ExpenseBucket.forCategory(
    List<Expense> allExpenses, this.category
    ) : expenses = allExpenses.where((expense) => expense.category == category)
    .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

  for (final expense in expenses) {
    sum += expense.amount;
  }
    return sum;
  }
}