import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:flutter/material.dart';

class AddTradesScreen extends StatefulWidget {
  const AddTradesScreen({super.key});

  @override
  State<AddTradesScreen> createState() => _AddTradesScreenState();
}

class _AddTradesScreenState extends State<AddTradesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ApplicationBar(title: "Add Trades", isShowBack: true),
      ),
      body: Center(child: Text("Coming Soon")).screenPadding(),
    );
  }
}
