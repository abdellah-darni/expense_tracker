import 'package:expense_tracker/core/database/database_helper.dart';
import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/core/theme/theme_provider.dart';
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

    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: BlueTheme.light,
      darkTheme: BlueTheme.dark,
      themeMode: currentTheme,
    );
  }
}
