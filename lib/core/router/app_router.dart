import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:expense_tracker/core/presentation/main_screen.dart';
import 'package:expense_tracker/features/expenses/presentation/screens/add_expense_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const MainScreen(),
      ),
      
      GoRoute(
        path: '/add-expense',
        name: 'addExpense',
        builder: (context, state) => const AddExpenseScreen(),
      ),
    ],
  );
});
