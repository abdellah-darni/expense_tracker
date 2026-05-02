import 'package:expense_tracker/controllers/expense_controller.dart';
import 'package:expense_tracker/widgets/breakdown_card.dart';
import 'package:expense_tracker/widgets/transaction_tile.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.secondaryContainer,
                  ],
                ),
                borderRadius: BorderRadius.circular(40),
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
                        color: Theme.of(context).colorScheme.tertiary,
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
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          expenseController.monthlySpend.toStringAsFixed(2),
                          style: const TextStyle(
                            height: 1.0,
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      // height: 40,
                      // width: 250,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x13FFFFFF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            expenseController.isSpendingLess
                                ? Icons.trending_down
                                : Icons.trending_up,
                            color: expenseController.isSpendingLess
                                ? Colors.green
                                : Colors.redAccent,
                            size: 25,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${expenseController.spendPersantageChange.toStringAsFixed(0)}% ${expenseController.isSpendingLess ? 'less' : 'more'} then last month",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Breakdown",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  "See Insghts",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: 140,
              child: expenseController.monthlyCategorySpending.isEmpty
                  ? const Center(child: Text("No expense this month!"))
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      children: expenseController
                          .monthlyCategorySpending
                          .entries
                          .map((entry) {
                            final category = entry.key;
                            final amount = entry.value;

                            final persentage =
                                expenseController.monthlySpend == 0
                                ? 0.0
                                : (amount / expenseController.monthlySpend);

                            return BreakdownCard(
                              title: category.displayName,
                              persentage: persentage,
                              icon: category.icon,
                              color: category.color,
                            );
                          })
                          .toList(),
                    ),
            ),
          ),

          const SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  "Last 7 Days",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          if (expenseController.recentActivity.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("No expenses in the last 7 days!"),
              ),
            )
          else
            ...expenseController.recentActivity.map((expense) {
              final category = expense.category;
              final monthNames = [
                "Jan",
                "Feb",
                "Mar",
                "Apr",
                "May",
                "Jun",
                "Jul",
                "Aug",
                "Sep",
                "Oct",
                "Nov",
                "Dec",
              ];
              final dateString =
                  "${category.displayName} • ${monthNames[expense.date.month - 1]} ${expense.date.day}";

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TransactionTile(
                  title: expense.description,
                  subtitle: dateString,
                  amount: expense.amount,
                  icon: category.icon,
                  color: category.color,
                ),
              );
            }),
        ],
      ),
    );
  }
}
