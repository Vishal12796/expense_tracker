import 'package:expense_tracker/core/extension/padding_extension.dart';
import 'package:expense_tracker/core/widgets/application_bar.dart';
import 'package:flutter/material.dart';

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
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ApplicationBar(title: "Dashboard"),
      ),
      body: Center(
        child: Text("Coming Soon"),
      ).screenPadding(),
    );
  }
}
