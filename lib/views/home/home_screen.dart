import 'package:expense_tracker/views/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/views/expense/expense_list/expense_list_screen.dart';
import 'package:expense_tracker/views/investment/trade_list/trades_list_screen.dart';
import 'package:expense_tracker/views/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/extension/context_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    DashboardScreen(),
    TradesListScreen(),
    ExpenseListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: context.color.primary,
        unselectedItemColor: context.color.onPrimaryFixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.candlestick_chart),
            label: "Trades",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_outlined),
            label: "Expense",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
