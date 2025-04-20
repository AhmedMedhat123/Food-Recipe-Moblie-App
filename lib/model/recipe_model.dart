class Recipe {
  final String name;
  final String image;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int reviewCount;
  final List<String> ingredients;
  final List<String> mealType;

  Recipe({
    required this.name,
    required this.image,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.reviewCount,
    required this.ingredients,
    required this.mealType,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] ?? 'No name',
      image: json['image'] ?? '',
      prepTimeMinutes: json['prepTimeMinutes'] ?? 0,
      cookTimeMinutes: json['cookTimeMinutes'] ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      ingredients: List<String>.from(json['ingredients'] ?? []),
      mealType: List<String>.from(json['mealType'] ?? []),
    );
  }

  int get totalTime => prepTimeMinutes + cookTimeMinutes;
}
