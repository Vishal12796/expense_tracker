import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/core/widgets/app_month_year_picker.dart';
import 'package:expense_tracker/core/widgets/app_year_picker.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:expense_tracker/views/dashboard/widgets/expenses_tab.dart';
import 'package:expense_tracker/views/dashboard/widgets/header_numbers.dart';
import 'package:expense_tracker/views/dashboard/widgets/expenses_monthly.dart';
import 'package:expense_tracker/views/dashboard/widgets/monthly_trades.dart';
import 'package:flutter/material.dart';

import '../../core/extension/context_extension.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 20),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 20,
          ),
          child: SizedBox(
            height: 60,
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: Text(
                    "Hello, John!",
                    style: context.text.titleMedium?.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    "https://mockmind-api.uifaces.co/content/human/80.jpg",
                  ),
                ),
              ],
            ),
          ).screenPadding(),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          spacing: 12,
          children: [
            const SizedBox(height: 2),
            HeaderNumbers(),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(30),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey.shade800,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: "Trades"),
                  Tab(text: "Expenses"),
                ],
              ),
            ),

            AppYearField(
              onChanged: (value) {},
              variant: MonthFiledVariant.small,
            ),

            Expanded(
              child: TabBarView(children: [MonthlyTrades(), ExpensesTab()]),
            ),
          ],
        ),
      ).screenPadding(),
    );
  }
}
