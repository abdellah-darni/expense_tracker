import 'package:expense_tracker/features/expenses/presentation/providers/expense_provider.dart';
import 'package:expense_tracker/features/expenses/presentation/widgets/breakdown_card.dart';
import 'package:expense_tracker/features/expenses/presentation/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final asyncExpensesPro = ref.watch(expenseProvider);

    return asyncExpensesPro.when(
      loading: () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: const Center(child: CircularProgressIndicator()),
      ),

      error: (error, stackTrace) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(child: Text('Failed to load expenses: $error')),
      ),

      data: (expenses) {
        final monthlySpend = ref.watch(monthlySpendProvider);
        final isSpendingLess = ref.watch(isSpendingLessProvider);
        final spendPercentage = ref.watch(spendPercentageChangeProvider);
        final monthlyCategorySpending = ref.watch(
          monthlyCategorySpendingProvider,
        );
        final recentActivity = ref.watch(recentActivityProvider);

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
                          'MONTHLY SPENDING',
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
                              r'$',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              monthlySpend.toStringAsFixed(2),
                              style: const TextStyle(
                                height: 1,
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
                                isSpendingLess
                                    ? Icons.trending_down
                                    : Icons.trending_up,
                                color: isSpendingLess
                                    ? Colors.green
                                    : Colors.redAccent,
                                size: 25,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "${spendPercentage.toStringAsFixed(0)}% ${isSpendingLess ? 'less' : 'more'} then last month",
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
                      'Breakdown',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'See Insghts',
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
                  child: monthlyCategorySpending.isEmpty
                      ? const Center(child: Text('No expense this month!'))
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: monthlyCategorySpending.entries.map((
                            entry,
                          ) {
                            final category = entry.key;
                            final amount = entry.value;

                            final persentage = monthlySpend == 0
                                ? 0.0
                                : (amount / monthlySpend);

                            return BreakdownCard(
                              title: category.displayName,
                              persentage: persentage,
                              icon: category.icon,
                              color: category.color,
                            );
                          }).toList(),
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
                      'Recent Activity',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Last 7 Days',
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

              if (recentActivity.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('No expenses in the last 7 days!'),
                  ),
                )
              else
                ...recentActivity.map((expense) {
                  final category = expense.category;
                  final monthNames = [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec',
                  ];
                  final dateString =
                      '${category.displayName} • ${monthNames[expense.date.month - 1]} ${expense.date.day}';

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
      },
    );
  }
}
