import 'package:expense_tracker/enums/expense_category.dart';
import 'package:expense_tracker/widgets/category_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  ExpenseCategory _selectedCategory = ExpenseCategory.food;

  final Map<ExpenseCategory, IconData> categoryIcons = {
    ExpenseCategory.food: Icons.restaurant,
    ExpenseCategory.work: Icons.work,
    ExpenseCategory.travel: Icons.flight,
    ExpenseCategory.shopping: Icons.shopping_bag,
    ExpenseCategory.bills: Icons.receipt_long,
    ExpenseCategory.other: Icons.more_horiz,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 250, 255),
      appBar: AppBar(
        title: const Text(
          "Add Expense",
          style: TextStyle(
            fontWeight: FontWeight.w700,
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
        backgroundColor: const Color.fromARGB(255, 246, 250, 255),
      ),
      body: Padding(
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
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "DESCRIPTION",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
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
                    fillColor: Colors.grey.withValues(alpha: 0.08),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "CATEGORY",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
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

              const SizedBox(height: 10),

              SizedBox(
                height: 110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryCard(
                      label: "Food", 
                      icon: Icons.restaurant, 
                      isSelected: _selectedCategory == ExpenseCategory.food,
                      onTap: () {
                        setState(() {
                          _selectedCategory = ExpenseCategory.food;
                        });
                      },
                    ),

                    CategoryCard(
                      label: "Work", 
                      icon: Icons.work, 
                      isSelected: _selectedCategory == ExpenseCategory.work,
                      onTap: () {
                        setState(() {
                          _selectedCategory = ExpenseCategory.work;
                        });
                      },
                    ),

                    CategoryCard(
                      label: "Bills", 
                      icon: Icons.receipt_long, 
                      isSelected: _selectedCategory == ExpenseCategory.bills,
                      onTap: () {
                        setState(() {
                          _selectedCategory = ExpenseCategory.bills;
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}
