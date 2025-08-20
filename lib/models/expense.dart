import 'package:uuid/uuid.dart';

final uuid = Uuid();


enum Category {
  food, travel, leisure, work 
}

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
}