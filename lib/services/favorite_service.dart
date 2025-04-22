import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recipe_app/model/recipe_model.dart';

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> toggleFavorite(Recipe recipe) async {
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(recipe.id.toString());

    final snapshot = await docRef.get();

    if (snapshot.exists) {
      await docRef.delete();
    } else {
      await docRef.set({
        'id': recipe.id,
        'name': recipe.name,
        'image': recipe.image,
        'prepTimeMinutes': recipe.prepTimeMinutes,
        'cookTimeMinutes': recipe.cookTimeMinutes,
        'reviewCount': recipe.reviewCount,
        'rating': recipe.rating,
        'ingredients': recipe.ingredients,
        'mealType': recipe.mealType,
        'caloriesPerServing': recipe.calories,
        'instructions': recipe.instructions,
      });
    }
  }

  Future<bool> isFavorite(String recipeId) async {
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(recipeId);
    final doc = await docRef.get();
    return doc.exists;
  }

  Stream<List<Recipe>> getFavorites() {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return Recipe(
              id: data['id'],
              name: data['name'],
              image: data['image'],
              prepTimeMinutes: data['prepTimeMinutes'],
              cookTimeMinutes: data['cookTimeMinutes'],
              reviewCount: data['reviewCount'],
              rating: (data['rating']).toDouble(),
              ingredients: List<String>.from(data['ingredients']),
              mealType: List<String>.from(data['mealType']),
              calories: data['caloriesPerServing'],
              instructions: List<String>.from(data['instructions']),
            );
          }).toList();
        });
  }
}
