import 'package:expense_tracker/views/expense/add_expense/binding/add_expense_binding.dart';
import 'package:expense_tracker/views/investment/add_trade/binding/add_trade_binding.dart';
import 'package:expense_tracker/views/dashboard/binding/dashboard_binding.dart';
import 'package:expense_tracker/views/expense/expense_list/binding/expense_list_binding.dart';
import 'package:expense_tracker/views/home/binding/home_binding.dart';
import 'package:expense_tracker/views/login/binding/login_binding.dart';
import 'package:expense_tracker/views/profile/binding/profile_binding.dart';
import 'package:expense_tracker/views/investment/trade_list/binding/trade_list_binding.dart';
import 'package:expense_tracker/core/router/routes.dart';
import 'package:expense_tracker/views/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/views/expense/add_expense/add_expense_screen.dart';
import 'package:expense_tracker/views/expense/expense_list/expense_list_screen.dart';
import 'package:expense_tracker/views/home/home_screen.dart';
import 'package:expense_tracker/views/investment/add_trade/add_trades_screen.dart';
import 'package:expense_tracker/views/investment/trade_list/trades_list_screen.dart';
import 'package:expense_tracker/views/login/login_screen.dart';
import 'package:expense_tracker/views/profile/profile_screen.dart';
import 'package:get/get.dart';

class AppRouter {
  static final initialLocation = AppRoutes.login;
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.addExpense,
      page: () => AddExpenseScreen(),
      binding: AddExpenseBinding(),
      // final expense = state.extra as ExpenseModel?;
      // return AddExpenseScreen(expense: expense);
      // return AddExpenseScreen();
    ),
    GetPage(
      name: AppRoutes.addTrade,
      page: () => AddTradesScreen(),
      binding: AddTradeBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.expenseList,
      page: () => ExpenseListScreen(),
      binding: ExpenseListBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.tradeList,
      page: () => TradesListScreen(),
      binding: TradeListBinding(),
    ),
  ];
}
