import 'package:expense_tracker/enums/expense_category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/services/expense_service.dart';
import 'package:flutter/cupertino.dart';

class ExpenseController extends ChangeNotifier {
  final ExpenseService _expenseService = ExpenseService();

  List<Expense> _expenses = [];
  // bool _isLoading = false;

  List<Expense> get expenses => _expenses;

  Future<void> loadExpenses() async {
    // _isLoading = true;
    notifyListeners();

    _expenses = await _expenseService.getAllExpenses();

    // _isLoading = false;
    notifyListeners();
  }

  Future<void> addExpense(Expense newExpense) async {
    _expenseService.insertExpense(newExpense);
    _expenses.insert(0, newExpense);
    notifyListeners();
  }

  double get monthlySpend {
    final now = DateTime.now();
    return _expenses
        .where((e) => e.date.month == now.month && e.date.year == now.year)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get _previousMonthSpend {
    final now = DateTime.now();

    final previousMonth = now.month == 1 ? 12 : now.month - 1;
    final previousYear = now.month == 1 ? now.year - 1 : now.year;

    return _expenses
        .where(
          (e) => e.date.month == previousMonth && e.date.year == previousYear,
        )
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get spendPersantageChange {
    final current = monthlySpend;
    final previous = _previousMonthSpend;

    if (previous == 0) {
      return current > 0 ? 100.0 : 0.0;
    }

    return ((current - previous) / previous).abs() * 100.0;
  }

  bool get isSpendingLess {
    return monthlySpend <= _previousMonthSpend;
  }

  Map<ExpenseCategory, double> get monthlyCategorySpending {
    final now = DateTime.now();
    Map<ExpenseCategory, double> totalsPerGategory = {};

    final thisMonthExpense = _expenses.where(
      (e) => e.date.month == now.month && e.date.year == now.year,
    );

    for (var expense in thisMonthExpense) {
      totalsPerGategory[expense.category] =
          (totalsPerGategory[expense.category] ?? 0) + expense.amount;
    }

    var sortedMap = totalsPerGategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Map.fromEntries(sortedMap);
  }

  List<Expense> get recentActivity {
    final now = DateTime.now();
    final evenDaysAgo = now.subtract(const Duration(days: 7));

    var recentList = _expenses.where((e) {
      return e.date.isAfter(evenDaysAgo) ||
          e.date.isAtSameMomentAs(evenDaysAgo);
    }).toList();

    recentList.sort((a, b) => b.date.compareTo(a.date));

    return recentList.take(2).toList();
  }
}
