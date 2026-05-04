import 'package:expense_tracker/features/expenses/domain/expense_category.dart';
import 'package:expense_tracker/features/expenses/domain/expense.dart';
import 'package:expense_tracker/features/expenses/data/expense_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseProvider extends AsyncNotifier<List<Expense>> {
  final ExpenseService _expenseService = ExpenseService();

  @override
  Future<List<Expense>> build() async {
    return _expenseService.getAllExpenses();
  }

  Future<void> addExpense(Expense newExpense) async {
    await _expenseService.insertExpense(newExpense);
    final currentList = state.value ?? [];
    state = AsyncData([newExpense, ...currentList]);
  }
}

final expenseProvider = AsyncNotifierProvider<ExpenseProvider, List<Expense>>(
  () {
    return ExpenseProvider();
  },
);

// --- DERIVED PROVIDERS (Replacing your old Getters) ---

// Replaces: get monthlySpend
final monthlySpendProvider = Provider<double>((ref) {
  // 1. Watch the main list.
  // .valueOrNull safely unwraps the AsyncNotifier data
  final expenses = ref.watch(expenseProvider).value ?? [];
  final now = DateTime.now();

  return expenses
      .where((e) => e.date.month == now.month && e.date.year == now.year)
      .fold(0, (sum, item) => sum + item.amount);
});

// Replaces: get _previousMonthSpend
final previousMonthSpendProvider = Provider<double>((ref) {
  final expenses = ref.watch(expenseProvider).value ?? [];
  final now = DateTime.now();
  final previousMonth = now.month == 1 ? 12 : now.month - 1;
  final previousYear = now.month == 1 ? now.year - 1 : now.year;

  return expenses
      .where(
        (e) => e.date.month == previousMonth && e.date.year == previousYear,
      )
      .fold(0, (sum, item) => sum + item.amount);
});

// Replaces: get spendPersantageChange
final spendPercentageChangeProvider = Provider<double>((ref) {
  // Providers can watch OTHER providers!
  final current = ref.watch(monthlySpendProvider);
  final previous = ref.watch(previousMonthSpendProvider);

  if (previous == 0) return current > 0 ? 100.0 : 0.0;
  return ((current - previous) / previous).abs() * 100.0;
});

// Replaces: get isSpendingLess
final isSpendingLessProvider = Provider<bool>((ref) {
  final current = ref.watch(monthlySpendProvider);
  final previous = ref.watch(previousMonthSpendProvider);
  return current <= previous;
});

// Replaces: get monthlyCategorySpending
final monthlyCategorySpendingProvider = Provider<Map<ExpenseCategory, double>>((
  ref,
) {
  final expenses = ref.watch(expenseProvider).value ?? [];
  final now = DateTime.now();
  final totals = <ExpenseCategory, double>{};

  final thisMonthExpenses = expenses.where(
    (e) => e.date.month == now.month && e.date.year == now.year,
  );

  for (final expense in thisMonthExpenses) {
    totals[expense.category] = (totals[expense.category] ?? 0) + expense.amount;
  }

  final sortedMap = totals.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return Map.fromEntries(sortedMap);
});

// Replaces: get recentActivity
final recentActivityProvider = Provider<List<Expense>>((ref) {
  final expenses = ref.watch(expenseProvider).value ?? [];
  final now = DateTime.now();
  final sevenDaysAgo = now.subtract(const Duration(days: 7));

  final recentList = expenses.where((e) {
    return e.date.isAfter(sevenDaysAgo) ||
        e.date.isAtSameMomentAs(sevenDaysAgo);
  }).toList()..sort((a, b) => b.date.compareTo(a.date));
  return recentList.take(2).toList();
});
