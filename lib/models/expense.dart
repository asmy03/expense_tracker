class Expense {
  final int? id;
  final double amount;
  final String category;
  final String description;
  final DateTime date;

  const Expense({
    this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
  });

  /// Converts an Expense object into a map for SQLite.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'description': description,
      'date': _formatDate(date),
    };
  }

  /// Creates an Expense object from a SQLite map.
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as int?,
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] as String,
      description: map['description'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }

  /// Creates a copy of the expense with selected fields changed.
  Expense copyWith({
    int? id,
    double? amount,
    String? category,
    String? description,
    DateTime? date,
  }) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  /// Stores dates in YYYY-MM-DD format for SQLite.
  static String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  @override
  String toString() {
    return 'Expense('
        'id: $id, '
        'amount: $amount, '
        'category: $category, '
        'description: $description, '
        'date: $date'
        ')';
  }
}
