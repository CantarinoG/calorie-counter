class Meal {
  final int id;
  final DateTime datetime;
  final double quantity;
  final int foodId;

  Meal(
    this.id,
    this.datetime,
    this.quantity,
    this.foodId,
  );

  static Meal fromMap(Map<String, dynamic> map) {
    return Meal(
      map['id'],
      DateTime.parse(map['datetime']),
      map['quantity'],
      map['foodId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'datetime': datetime.toString(),
      'quantity': quantity,
      'foodId': foodId,
    };
  }
}
