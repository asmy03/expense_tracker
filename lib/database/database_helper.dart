import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _databaseName = 'expense_tracker.db';
  static const int _databaseVersion = 1;

  static const String tableExpenses = 'expenses';

  static const String columnId = 'id';
  static const String columnAmount = 'amount';
  static const String columnCategory = 'category';
  static const String columnDescription = 'description';
  static const String columnDate = 'date';

  static Database? _database;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $tableExpenses (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnAmount REAL NOT NULL,
        $columnCategory TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnDate TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertExpense(Map<String, dynamic> expense) async {
    final db = await database;

    return await db.insert(
      tableExpenses,
      expense,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getExpenses() async {
    final db = await database;

    return await db.query(
      tableExpenses,
      orderBy: '$columnDate DESC, $columnId DESC',
    );
  }

  Future<Map<String, dynamic>?> getExpense(int id) async {
    final db = await database;

    final results = await db.query(
      tableExpenses,
      where: '$columnId = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isEmpty) {
      return null;
    }

    return results.first;
  }

  Future<int> updateExpense(int id, Map<String, dynamic> expense) async {
    final db = await database;

    return await db.update(
      tableExpenses,
      expense,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteExpense(int id) async {
    final db = await database;

    return await db.delete(
      tableExpenses,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
