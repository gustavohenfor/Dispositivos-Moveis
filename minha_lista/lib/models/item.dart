
class Item {
  final String id;
  final String name;
  final String userId;
  final DateTime createdAt;

  Item({
    required this.id,
    required this.name,
    required this.userId,
    required this.createdAt,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      userId: map['user_id'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
