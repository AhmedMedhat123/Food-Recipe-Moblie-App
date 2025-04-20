class Recipe {
  final String name;
  final String image;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int reviewCount;
  final double rating;
  final List<String> ingredients;
  final List<String> mealType;
  final int calories;
  final List<String> instructions;

  Recipe({
    required this.name,
    required this.image,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.reviewCount,
    required this.rating,
    required this.ingredients,
    required this.mealType,
    required this.calories,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] ?? 'No name',
      image: json['image'] ?? '',
      prepTimeMinutes: json['prepTimeMinutes'] ?? 0,
      cookTimeMinutes: json['cookTimeMinutes'] ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      ingredients: List<String>.from(json['ingredients'] ?? []),
      mealType: List<String>.from(json['mealType'] ?? []),
      calories: json['caloriesPerServing'] ?? 0,
      instructions: List<String>.from(json['instructions'] ?? []),
    );
  }

  int get totalTime => prepTimeMinutes + cookTimeMinutes;
}
