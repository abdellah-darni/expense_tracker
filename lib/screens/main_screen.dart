import 'package:expense_tracker/screens/add_expense_screen.dart';
import 'package:expense_tracker/screens/dashboard_screen.dart';
import 'package:expense_tracker/screens/expense_history_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const Dashboard(),
    const ExpenseHistoryScreen(),
    const Center(child: Text("Stats Screen Coming Soon")),
    const Center(child: Text("Profile Screen Coming Soon")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 250, 255, 1),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF6FAFF),
        title: const Text(
          "The Fluid Accountant",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(backgroundImage: AssetImage("assets/avatar.jpg")),
        ),
        actions: [
          IconButton(
            onPressed: () => debugPrint("somthing"),
            icon: const Icon(Icons.settings, color: Color(0xFF171C20)),
          ),
        ],
      ),

      body: _pages[_selectedIndex],

      floatingActionButton: Container(
        width: 65,
        height: 65,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 31, 48, 64),
              Color.fromARGB(255, 72, 105, 117),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (context) => const AddExpenseScreen(),
              ),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromRGBO(50, 74, 95, 1),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 10,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: "DASHBOARD",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "HISTORY",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: "STATS",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "PROFILE"),
        ],
      ),
    );
  }
}
