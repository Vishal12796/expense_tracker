import 'package:expense_tracker/core/router/routes.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/views/expense/add_expense/add_expense_screen.dart';
import 'package:expense_tracker/views/home/home_screen.dart';
import 'package:expense_tracker/views/investment/add_trade/add_trades_screen.dart';
import 'package:expense_tracker/views/login/login_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: AppRoutes.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/home',
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
