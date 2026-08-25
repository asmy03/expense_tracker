import 'package:flutter_test/flutter_test.dart';

import 'package:expense_tracker/main.dart';

void main() {
  testWidgets('Expense tracker dashboard loads', (WidgetTester tester) async {
    await tester.pumpWidget(const ExpenseTrackerApp());

    expect(find.text('My Expenses'), findsOneWidget);
    expect(find.text('Total Spent'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Transactions'), findsOneWidget);
    expect(find.text('Spending Overview'), findsOneWidget);
    expect(find.text('Recent Expenses'), findsOneWidget);
    expect(find.text('No expenses yet'), findsOneWidget);
    expect(find.text('Add Expense'), findsOneWidget);

    // The initial dashboard contains two ₹0.00 values:
    // Total Spent and Today.
    expect(find.text('₹ 0.00'), findsNWidgets(2));
  });
}
