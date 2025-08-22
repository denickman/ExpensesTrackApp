import 'package:flutter/material.dart';
import 'package:third_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  /*
  Все поля, которые ты передаёшь в конструктор NewExpense, хранятся внутри объекта widget.
  Это специальное свойство, которое Flutter автоматически предоставляет в каждом классе State.

  State отделён от Widget.
  Поэтому всё, что передано в конструктор NewExpense, доступно внутри State только через widget.

  widget в классе State — это ссылка на сам StatefulWidget (NewExpense).
  Через него мы получаем доступ к параметрам конструктора (onAddExpense, key, и т.п.), 
  которые были переданы при создании виджета. 
  */
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

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
  Category? _selectedCategory;

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

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
      _amountController.text,
    ); // tryParse("abc") => null
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      // show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered...',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    // proceed if all required data exist

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory!,
      ),
    );

     Navigator.pop(context);
  }

  // Lifecycle

  @override
  Widget build(BuildContext context) {

/*
.viewInsets - показывает области экрана, которые перекрыты "системными UI-элементами" (обычно клавиатура).
По сути — это «внутренние вставки» (insets), которые нужно учесть, чтобы твой контент 
не оказался под клавиатурой или системной навигацией.
*/
final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

/*
SingleChildScrollView - позволяет прокручивать содержимое, если оно не помещается на экране.
Работает только с одним ребёнком (отсюда и название).
Обычно ребёнком бывает Column или Row.
Если контента меньше, чем экран → скролла нет.
Если контента больше → появляется скролл (по вертикали или горизонтали).


SizedBox(height: double.infinity - почему добавлено еще ? 

SingleChildScrollView по своей природе растягивается только по содержимому.
Если ребёнок (Column) не ограничен по высоте, то:
он возьмёт высоту ровно под свои элементы (например, 400 px).
и SingleChildScrollView тоже станет такой высоты.

SizedBox(height: double.infinity) нужен, чтобы:
заставить форму занимать всю высоту экрана (ограничить SingleChildScrollView от "схлопывания");
корректно работать с клавиатурой и паддингами;
позволить скроллу появляться только тогда, когда реально не хватает места.

🔹 Что это даёт на практике
Когда контента мало → форма всё равно растягивается на высоту экрана, 
и элементы «прижимаются» куда надо (например, паддинг снизу учитывает клавиатуру).

Когда контента много → SingleChildScrollView может нормально скроллиться, 
потому что у него теперь есть «рамка» (высота экрана).
*/
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
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
        
              const SizedBox(height: 16),
        
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory, // if null we see hint
                    hint: const Text("Choose category"),
                    items: Category.values
                        .map(
                          // map - always retur iterable
                          (categoryItem) => DropdownMenuItem(
                            value: categoryItem,
                            child: Text(
                              categoryItem.name
                                  .toUpperCase(), // .toString() returns "Category.food"
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      // if (value == null) {
                      //   return;
                      // }
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
        
                  const Spacer(),
        
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
        
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: Text('Save Expense'),
                  ),
                ],
              ),
            ],
          ),
        ),
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
