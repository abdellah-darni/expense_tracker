import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/services/expense_service.dart';
import 'package:flutter/cupertino.dart';

class ExpenseController {
  final ExpenseService _expenseService = ExpenseService();

  Future<void> addExpense(Expense newExpense) async {
    final ExpenseService expenseService = _expenseService;

    _expenseService.insertExpense(newExpense);
  }
}