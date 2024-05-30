class Meal {
  final int id;
  final DateTime datetime;
  final int foodId;

  Meal(
    this.id,
    this.datetime,
    this.foodId,
  );

  static Meal fromMap(Map<String, dynamic> map) {
    return Meal(
      map['id'],
      map['datetime'],
      map['foodId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'datetime': datetime.toString(),
      'foodId': foodId,
    };
  }
}
