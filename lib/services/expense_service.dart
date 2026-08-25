import '../database/database_helper.dart';
import '../models/expense.dart';

class ExpenseService {
  final DatabaseHelper _databaseHelper;

  ExpenseService({DatabaseHelper? databaseHelper})
    : _databaseHelper = databaseHelper ?? DatabaseHelper.instance;

  Future<int> addExpense(Expense expense) async {
    final expenseMap = expense.toMap();

    // The database generates the ID automatically.
    expenseMap.remove('id');

    return await _databaseHelper.insertExpense(expenseMap);
  }

  Future<List<Expense>> getAllExpenses() async {
    final expenseMaps = await _databaseHelper.getExpenses();

    return expenseMaps
        .map((expenseMap) => Expense.fromMap(expenseMap))
        .toList();
  }

  Future<Expense?> getExpenseById(int id) async {
    final expenseMap = await _databaseHelper.getExpense(id);

    if (expenseMap == null) {
      return null;
    }

    return Expense.fromMap(expenseMap);
  }

  Future<int> updateExpense(Expense expense) async {
    if (expense.id == null) {
      throw ArgumentError('An expense ID is required to update an expense.');
    }

    final expenseMap = expense.toMap();
    expenseMap.remove('id');

    return await _databaseHelper.updateExpense(expense.id!, expenseMap);
  }

  Future<int> deleteExpense(int id) async {
    return await _databaseHelper.deleteExpense(id);
  }

  Future<void> closeDatabase() async {
    await _databaseHelper.closeDatabase();
  }
}
