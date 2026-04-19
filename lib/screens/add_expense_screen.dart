import 'package:expense_tracker/controllers/expense_controller.dart';
import 'package:expense_tracker/enums/expense_category.dart';
import 'package:expense_tracker/enums/payment_method.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  ExpenseController _expenseController = ExpenseController();

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

    if (enterdAmount <= 0 || enterdDesciption.isEmpty){
      return;
    }

    final newExpense = Expense(
      id: Uuid().v4(),
      amount: enterdAmount,
      description: enterdDesciption,
      category: _selectedCategory,
      date: _selectedDate,
      paymentMethod: _selectedPayment,
      note: _noteController.text.isEmpty ? null : _noteController.text,
    );

    _expenseController.addExpense(newExpense);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Expense",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF171C20),
          ),
        ),
        
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
          onPressed: () {
              
          },
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: const Text("A popup"),
                        content: const Text("I just want to add a popup i didn't think much of the content."),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Got it!")
                          )
                        ],
                      );
                    }
                );
              },
            ),
          )
        ],
        backgroundColor: const Color(0xFFF6FAFF),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 12,),
                const Center(
                  child: Text(
                      "AMOUNT",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12
                      ),
                  ),
                ),
                SizedBox(
                  // width: 200,
                  child: TextField(
                    cursorColor: Colors.black,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    controller: _amountController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
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
        
                SizedBox(height: 20,),
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
                        color: Color(0xFF43474C)
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
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "What did you buy?",
                      hintStyle: TextStyle(
                        color: Colors.grey.withValues(alpha: 0.4),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF0F4F9),
        
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:  0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "CATEGORY",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Color(0xFF43474C)
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
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
                      String labelName = category.name[0].toUpperCase() + category.name.substring(1);
        
                      return CategoryCard(
                        label: labelName, 
                        icon: categoryIcons[category] ?? Icons.category , 
                        isSelected: _selectedCategory == category, 
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        }
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
                        color: Color(0xFF43474C)
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
                      color: Color(0xFFF0F4F9),
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
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        
                        Icon(
                          Icons.calendar_month,
                          color: Colors.black87.withValues(alpha: 0.8),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
        
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "PAYMENT METHOD",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Color(0xFF43474C)
                    ),
                  ),
                ),
                const SizedBox(height: 8),
        
                DropdownButtonFormField(
                  initialValue: _selectedPayment,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF0F4F9),
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
                    String lableName = method.name[0].toUpperCase() + method.name.substring(1);
                    return DropdownMenuItem(
                      value: method,
                      child: Text(lableName)
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null){
                      setState(() {
                        _selectedPayment = value;
                      });
                    }
                  }
                ),
        
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ADD A NOTE",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Color(0xFF43474C)
                    ),
                  ),
                ),
        
                const SizedBox(height: 8),
        
                TextField(
                  controller: _noteController,
                  maxLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: "Additional details or receipt notes...",
                    hintStyle: TextStyle(
                      color: Colors.grey.withValues(alpha: 0.4),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF0F4F9),
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
                    onPressed: (){}, 
                    icon: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Save Expense",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF324A5F), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                  ),
                )
        
              ],
            ),
        ),
      ),
    );
  }
}
