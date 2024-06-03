class Food {
  final int id;
  final String name;
  final double calories;
  final double carbs;
  final double proteins;
  final double fats;
  bool isDeleted = false;

  Food(
    this.id,
    this.name,
    this.calories,
    this.carbs,
    this.proteins,
    this.fats, [
    this.isDeleted = false,
  ]);

  static Food fromMap(Map<String, dynamic> map) {
    return Food(
      map['id'],
      map['name'],
      map['calories'],
      map['carbs'],
      map['proteins'],
      map['fats'],
      (map['isDeleted'] == 0) ? false : true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'carbs': carbs,
      'proteins': proteins,
      'fats': fats,
      'isDeleted': isDeleted,
    };
  }
}
