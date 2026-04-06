import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/router/routes.dart';
import 'package:expense_tracker/core/widgets/app_button.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ApplicationBar(title: "Home"),
      ),
      body: Column(
        children: [
          SizedBox(height: 12),
          AppButton(
            title: "Expense List",
            onTap: () {
              context.push(AppRoutes.expense_list);
            },
          ),
        ],
      ).screenPadding(),
    );
  }
}
