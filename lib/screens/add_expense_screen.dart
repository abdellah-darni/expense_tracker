import 'package:expense_tracker/controllers/expense_controller.dart';
import 'package:expense_tracker/enums/expense_category.dart';
import 'package:expense_tracker/enums/payment_method.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  ExpenseCategory _selectedCategory = ExpenseCategory.food;

  final Map<ExpenseCategory, IconData> categoryIcons = {
    ExpenseCategory.food: Icons.restaurant,
    ExpenseCategory.work: Icons.work,
    ExpenseCategory.travel: Icons.flight,
    ExpenseCategory.shopping: Icons.shopping_bag,
    ExpenseCategory.bills: Icons.receipt_long,
    ExpenseCategory.other: Icons.more_horiz,
  };

  PaymentMethod _selectedPayment = PaymentMethod.cash;

  DateTime _selectedDate = DateTime.now();

  void _presentDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _saveExpense() {
    final enterdAmount = double.tryParse(_amountController.text) ?? 0.0;
    final enterdDesciption = _descriptionController.text;

    if (enterdAmount <= 0 || enterdDesciption.isEmpty) {
      return;
    }

    final newExpense = Expense(
      id: const Uuid().v4(),
      amount: enterdAmount,
      description: enterdDesciption,
      category: _selectedCategory,
      date: _selectedDate,
      paymentMethod: _selectedPayment,
      note: _noteController.text.isEmpty ? null : _noteController.text,
    );

    context.read<ExpenseController>().addExpense(newExpense);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Expense",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {
                // ignore: inference_failure_on_function_invocation
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("A popup"),
                      content: const Text(
                        "I just want to add a popup i didn't think much of the content.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Got it!"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  "AMOUNT",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                ),
              ),
              SizedBox(
                // width: 200,
                child: TextField(
                  cursorColor: Theme.of(context).colorScheme.shadow,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  controller: _amountController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(fontSize: 25),
                  decoration: InputDecoration(
                    hintText: "0.00",
                    hintStyle: TextStyle(
                      color: Colors.grey.withValues(alpha: 0.4),
                    ),
                    prefixIcon: Icon(
                      Icons.attach_money,
                      size: 35,
                      color: Colors.grey.withValues(alpha: 0.99),
                    ),
                    suffixIcon: const SizedBox(width: 48),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              Container(
                height: 1,
                width: 180,
                color: Colors.grey.withValues(alpha: 0.5),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "DESCRIPTION",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: TextField(
                  cursorColor: Colors.black,
                  controller: _descriptionController,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.shadow),
                  decoration: InputDecoration(
                    hintText: "What did you buy?",
                    hintStyle: TextStyle(
                      color: Colors.grey.withValues(alpha: 0.4),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "CATEGORY",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "View All",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),

              // const SizedBox(height: 10),
              SizedBox(
                height: 110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: ExpenseCategory.values.map((category) {
                    String labelName =
                        category.name[0].toUpperCase() +
                        category.name.substring(1);

                    return CategoryCard(
                      label: labelName,
                      icon: categoryIcons[category] ?? Icons.category,
                      isSelected: _selectedCategory == category,
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "DATE",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 0),

              InkWell(
                onTap: _presentDatePicker,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey.withValues(alpha: 0.6),
                        size: 20,
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          "${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.shadow,
                          ),
                        ),
                      ),

                      Icon(
                        Icons.calendar_month,
                        color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.8),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "PAYMENT METHOD",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              DropdownButtonFormField(
                initialValue: _selectedPayment,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.credit_card,
                    color: Colors.grey.withValues(alpha: 0.6),
                  ),
                ),

                icon: const Icon(Icons.keyboard_arrow_down),

                items: PaymentMethod.values.map((method) {
                  String lableName =
                      method.name[0].toUpperCase() + method.name.substring(1);
                  return DropdownMenuItem(
                    value: method,
                    child: Text(lableName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedPayment = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ADD A NOTE",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: _noteController,
                maxLines: 1,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(color: Theme.of(context).colorScheme.shadow),
                decoration: InputDecoration(
                  hintText: "Additional details or receipt notes...",
                  hintStyle: TextStyle(
                    color: Colors.grey.withValues(alpha: 0.4),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _saveExpense,
                  icon: Icon(Icons.check_circle, color: Theme.of(context).colorScheme.surface),
                  label: Text(
                    "Save Expense",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
