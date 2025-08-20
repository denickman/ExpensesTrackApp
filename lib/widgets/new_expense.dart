import 'package:flutter/material.dart';
import 'package:third_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  /*
  IF YOU HAVE MULTIPLE FIELDS you need MULTIPLE CONTROLLERS
  TextEditingController - хранит текущее значение текста (.text),
  умеет управлять курсором, выделением,
  и рассылает уведомления слушателям (listeners) при изменении текста.
  По сути это менеджер состояния для TextField.

  Если ты не вызовешь dispose(), то TextEditingController продолжит жить в памяти, 
  потому что на него могут быть подписаны слушатели (addListener).
*/

  // Properties
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  // Methods
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(
      now.year - 1,
      now.month,
      now.day,
    ); // today - 1 year

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    // old style
    // .then((value) {
    // });

    /*
      если не использовать  setState(() дальше то Flutter не «узнает», что переменная изменилась.
      UI не перестроится.
      В итоге на экране по-прежнему будет «No date selected», хотя в _selectedDate уже есть дата.
      поэтому _selectedDate обязательно здесь
    */
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // Lifecycle

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            // keyboardType: TextInputType.text, // - TextInputType.text established by default
            decoration: const InputDecoration(
              // placeholder
              label: Text('Title'),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,

                  // keyboardType: TextInputType.text, // - TextInputType.text established by default
                  decoration: const InputDecoration(
                    // placeholder
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),

              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_amountController.text);
                },
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
