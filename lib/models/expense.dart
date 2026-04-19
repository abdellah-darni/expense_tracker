import 'package:expense_tracker/enums/expense_category.dart';
import 'package:expense_tracker/enums/payment_method.dart';

class Expense {
  final String id;
  final double amount;
  final String description;
  final ExpenseCategory category;
  final DateTime date;
  final PaymentMethod paymentMethod;
  final String? note;
  final bool isDeleted;

  Expense({
    required this.id,
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
    required this.paymentMethod,
    this.note,
    this.isDeleted = false,
  });

  
}