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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'category': category.name,
      'date': date.toIso8601String(),
      'paymentMethod': paymentMethod.name,
      'note': note,
      'isDeleted': isDeleted ? 1 : 0,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as String,
      amount: map['amount'] as double,
      description: map['description'] as String,
      category: ExpenseCategory.values.byName(map['category'] as String),
      date: DateTime.parse(map['date'] as String),
      paymentMethod: PaymentMethod.values.byName(
        map['paymentMethod'] as String,
      ),
      note: map['note'] as String,
      isDeleted: map['isDeleted'] == 1,
    );
  }
}
