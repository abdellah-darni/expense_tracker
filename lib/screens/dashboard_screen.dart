import 'package:expense_tracker/controllers/expense_controller.dart';
import 'package:expense_tracker/screens/add_expense_screen.dart';
import 'package:expense_tracker/widgets/breakdown_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    final expenseController = context.watch<ExpenseController>();
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6FAFF),
        title: const Text(
          "The Fluid Accountant",
          style: TextStyle(
              fontWeight: FontWeight.w700,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/avatar.jpg"),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => print("somthing"),
            icon: const Icon(Icons.settings, color: Color(0xFF171C20),)
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color.fromARGB(255, 31, 48, 64), Color.fromARGB(255, 72, 105, 117)]
                  ),
                  borderRadius: BorderRadius.circular(40)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MONTHLY SPENDING",
                        style: TextStyle(
                          color: Color.fromARGB(200,159, 185, 211),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          wordSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Icon(Icons.attach_money, color: Color.fromARGB(200,159, 185, 211) , size: 32,),
                          Text(
                            "\$",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                            ),
                          ),
                          SizedBox(width: 4,),
                          Text(
                            expenseController.monthlySpend.toStringAsFixed(2),
                            style: TextStyle(
                              height: 1.0,
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              color: Colors.white
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        // height: 40,
                        // width: 250,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(20, 255, 255, 255),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              expenseController.isSpendingLess ? Icons.trending_down : Icons.trending_up,
                              color: expenseController.isSpendingLess ?Colors.green : Colors.redAccent, 
                              size: 25,
                            ),
                            SizedBox(width: 8,),
                            Text(
                              "${expenseController.spendPersantageChange.toStringAsFixed(0)}% ${expenseController.isSpendingLess ? 'less' : 'more'} then last month",
                              style: TextStyle(
                                color: Color.fromARGB(200, 255, 255, 255),
                                fontSize: 12,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Breakdown",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(23, 28, 32, 1),
                    ),
                  ),
                  Text(
                    "See Insghts",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 50, 74, 95),
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              SizedBox(height: 15,),

              SizedBox(
                height: 140,
                child: expenseController.monthlyCategorySpending.isEmpty
                  ? const Center(child: Text("No expense this month!"))
                  : ListView(
                    scrollDirection: Axis.horizontal,
                    children: expenseController.monthlyCategorySpending.entries.map((entry) {
                      final category = entry.key;
                      final amount = entry.value;

                      final persentage = expenseController.monthlySpend == 0
                        ? 0.0
                        : (amount / expenseController.monthlySpend);
                      
                      String lableName = category.name[0].toUpperCase() + category.name.substring(1);

                      IconData icon = Icons.restaurant;
                      Color color = Colors.deepOrange;

                      return BreakdownCard(title: lableName, persentage: persentage, icon: icon, color: color);
                    }).toList(),
                  ),
              )
              // Row
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 65,
        height: 65,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 31, 48, 64), Color.fromARGB(255, 72, 105, 117)]
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 15,
              offset: Offset(0, 8)
            )
          ]
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddExpenseScreen())
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: 32,),
        ),
      ),
    );
  }
}