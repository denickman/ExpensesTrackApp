import 'package:flutter/material.dart';

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
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

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

          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,

            // keyboardType: TextInputType.text, // - TextInputType.text established by default
            decoration: const InputDecoration(
              // placeholder
              prefixText: '\$ ',
              label: Text('Amount'),
            ),
          ),

          Row(
            children: [
              TextButton(onPressed: () {}, child: const Text("Cancel")),

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
}
