import 'package:flutter/material.dart';

enum ExpenseCategory {
  food(displayName: "Food", icon: Icons.restaurant, color: Colors.orange),
  travel(displayName: "Travel", icon: Icons.flight, color: Colors.purple),
  work(displayName: "Work", icon: Icons.work, color: Colors.blue),
  shopping(
    displayName: "Shopping",
    icon: Icons.shopping_bag,
    color: Color.fromRGBO(72, 52, 162, 1),
  ),
  bills(
    displayName: "Bills",
    icon: Icons.receipt_long,
    color: Color.fromRGBO(0, 108, 74, 1),
  ),
  other(displayName: "Other", icon: Icons.more_horiz, color: Colors.grey);

  final String displayName;
  final IconData icon;
  final Color color;

  const ExpenseCategory({
    required this.displayName,
    required this.icon,
    required this.color,
  });
}
