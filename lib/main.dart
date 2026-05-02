import 'package:expense_tracker/controllers/expense_controller.dart';
import 'package:expense_tracker/helper/database_helper.dart';
import 'package:expense_tracker/screens/add_expense_screen.dart';
import 'package:expense_tracker/screens/dashboard_screen.dart';
import 'package:expense_tracker/screens/main_screen.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await DatabaseHelper.instance.database;
    print("DATABASE CREATED SUCCESSFULLY!");
  } catch (e) {
    print("ERROR CREATING DATABASE: $e");
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => ExpenseController()..loadExpenses(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF6FAFF),
      ),
      home: MainScreen(),
    );
  }
}
