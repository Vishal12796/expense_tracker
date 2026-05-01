import 'package:expense_tracker/core/dialog/common_dialog.dart';
import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/router/routes.dart';
import 'package:expense_tracker/core/theme/spacing.dart';
import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/core/widgets/app_month_year_picker.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:expense_tracker/views/investment/trade_list/widgets/trade_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extension/context_extension.dart';

class TradesListScreen extends StatefulWidget {
  const TradesListScreen({super.key});

  @override
  State<TradesListScreen> createState() => _TradesListScreenState();
}

class _TradesListScreenState extends State<TradesListScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget header() {
    return Row(
      spacing: Spacing.sectionSpace,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppMonthYearField(
          onChanged: (value) {
            print(value);
          },
          variant: MonthFiledVariant.big,
        ),
        Text(
          "${Utils.moneySymbol}1800",
          style: context.text.headlineLarge?.copyWith(color: Colors.green),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ApplicationBar(title: "Monthly Trades"),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_trade_fab',
        onPressed: () => {Get.toNamed(AppRoutes.addTrade)},
        child: Icon(Icons.add),
      ),
      body: Column(
        spacing: 12,
        children: [
          const SizedBox(height: 8),
          header(),
          Flexible(
            flex: 1,
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 4);
              },
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key("${index}"),
                  // to do change id
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    return await CommonDialog.showConfirmDialog(
                      context: context,
                      title: "Delete Trade",
                      message: "Are you sure you want to delete this trade?",
                      confirmText: "Delete",
                    );
                  },
                  background: Card.filled(
                    elevation: 2,
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.red,
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  onDismissed: (direction) {},
                  child: TradeListItem(index: index),
                );
              },
            ),
          ),
        ],
      ).screenPadding(),
    );
  }
}
