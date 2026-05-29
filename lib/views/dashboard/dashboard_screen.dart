import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/widgets/app_year_picker.dart';
import 'package:expense_tracker/core/widgets/app_month_year_picker.dart';
import 'package:expense_tracker/views/dashboard/controller/dashboard_controller.dart';
import 'package:expense_tracker/views/dashboard/widgets/expenses_tab.dart';
import 'package:expense_tracker/views/dashboard/widgets/header_numbers.dart';
import 'package:expense_tracker/views/dashboard/widgets/monthly_trades.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/extension/context_extension.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with AutomaticKeepAliveClientMixin {
  final DashboardController controller = Get.find<DashboardController>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 20),
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
                const CircleAvatar(
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
        initialIndex: 1, // Default to Expenses tab to show the new analytics
        animationDuration: Duration.zero,
        child: Column(
          spacing: 12,
          children: [
            const SizedBox(height: 2),
            const HeaderNumbers().screenPadding(),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(4),
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
                tabs: const [
                  Tab(text: "Trades"),
                  Tab(text: "Expenses"),
                ],
              ),
            ),

            Obx(
              () => AppYearField(
                initialDate: DateTime(controller.selectedYear.value),
                onChanged: (value) {
                  controller.updateYear(value);
                },
                variant: MonthFiledVariant.big,
              ),
            ),

            const Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [MonthlyTrades(), ExpensesTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
