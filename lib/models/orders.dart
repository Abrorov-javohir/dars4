
class Order {
  final String id;
  final Map<String, dynamic> products;
  final DateTime date;

  Order({
    required this.id,
    required this.products,
    required this.date,
  });
}
