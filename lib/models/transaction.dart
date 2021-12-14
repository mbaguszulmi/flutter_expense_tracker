class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;

  Transaction({this.id = "", this.title = "", this.amount = 0, required this.date});

  bool get isExpense => amount < 0;
  bool get isIncome => amount >= 0;
}
