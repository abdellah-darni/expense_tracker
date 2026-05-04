import 'package:expense_tracker/helper/database_helper.dart';
import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:expense_tracker/screens/main_screen.dart';
import 'package:expense_tracker/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await DatabaseHelper.instance.database;
    debugPrint('DATABASE CREATED SUCCESSFULLY!');
  } on Exception catch (e) {
    debugPrint('ERROR CREATING DATABASE: $e');
  }

  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context) => ExpenseController()..loadExpenses(),
  //     child: const MyApp(),
  //   ),
  // );

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: BlueTheme.light,
      darkTheme: BlueTheme.dark,
      themeMode: currentTheme,
      home: const MainScreen(),
    );
  }
}
