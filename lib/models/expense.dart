import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

final uuid = Uuid();


enum Category {
  food, travel, leisure, work 
}

// Map - Dictionary
const categoryItems = {
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



  String get formattedDate {
    return formatter.format(date);
  }
}