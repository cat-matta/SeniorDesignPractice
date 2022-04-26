class Transaction {
  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final String category;
  Transaction(
      {required this.id,
      required this.name,
      required this.amount,
      required this.date,
      this.category = "None"});
}
