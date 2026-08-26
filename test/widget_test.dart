import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/services/expense_service.dart';

class FakeExpenseService extends ExpenseService {
  @override
  Future<List<Expense>> getAllExpenses() async {
    return [];
  }

  @override
  Future<int> deleteExpense(int id) async {
    return 1;
  }
}

void main() {
  testWidgets('Expense tracker dashboard loads', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: HomeScreen(expenseService: FakeExpenseService())),
    );

    await tester.pumpAndSettle();

    expect(find.text('My Expenses'), findsOneWidget);
    expect(find.text('Total Spent'), findsOneWidget);
    expect(find.text('Spending Overview'), findsOneWidget);
    expect(find.text('Recent Expenses'), findsOneWidget);
    expect(find.text('Add Expense'), findsOneWidget);
  });
}
