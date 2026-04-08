import 'package:expense_tracker/core/router/routes.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/views/expense/add_expense/add_expense_screen.dart';
import 'package:expense_tracker/views/expense/expense_list/expense_list_screen.dart';
import 'package:expense_tracker/views/home/home_screen.dart';
import 'package:expense_tracker/views/investment/add_expense/add_trades_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutes.home,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/add_expense',
        name: AppRoutes.addExpense,
        builder: (context, state) {
          final expense = state.extra as ExpenseModel?;
          return AddExpenseScreen(expense: expense);
        },
      ),
      GoRoute(
        path: '/add_trade',
        name: AppRoutes.addTrade,
        builder: (context, state) => AddTradesScreen(),
      ),
    ],
  );
}
