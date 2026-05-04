import 'package:expense_tracker/helper/database_helper.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseService {
  Future<Database> get _db async => DatabaseHelper.instance.database;

  Future<void> insertExpense(Expense expense) async {
    final db = await _db;

    await db.insert(
      'expenses',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Expense>> getAllExpenses() async {
    final db = await _db;

    final List<Map<String, dynamic>> expensesMap = await db.query(
      'expenses',
      where: 'isDeleted = ?',
      whereArgs: [0],
      orderBy: 'date DESC',
    );

    return expensesMap.map(Expense.fromMap).toList();
  }

  Future<void> softDeleteExpense(String id) async {
    final db = await _db;

    await db.update(
      'expenses',
      {'isDeleted': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
