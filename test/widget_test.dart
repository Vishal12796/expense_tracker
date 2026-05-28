import 'package:expense_tracker/core/widgets/app_month_year_picker.dart';
import 'package:expense_tracker/core/widgets/app_year_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('year picker opens with an out-of-range initial year', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppYearField(
            initialDate: DateTime(2100),
            variant: MonthFiledVariant.small,
          ),
        ),
      ),
    );

    await tester.tap(find.text('2100'));
    await tester.pumpAndSettle();

    expect(find.text('Select Year'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
