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
    this.fats,
  );
}
