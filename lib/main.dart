import 'package:flutter/material.dart';
import 'package:third_app/widgets/expenses.dart';
import 'package:third_app/widgets/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Expenses(),
    ),
  );
}