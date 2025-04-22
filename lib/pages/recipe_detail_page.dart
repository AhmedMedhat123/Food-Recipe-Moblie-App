import 'package:flutter/material.dart';
import 'package:food_recipe_app/services/favorite_service.dart';
import 'package:food_recipe_app/widgets/bottom_nav_bar.dart';
import 'package:food_recipe_app/model/recipe_model.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  RecipeDetailPage({required this.recipe});

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  int servings = 1;
  bool isFavorite = false;
  final FavoriteService _favoriteService = FavoriteService();

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final favorite = await _favoriteService.isFavorite(
      widget.recipe.id.toString(),
    );
    setState(() {
      isFavorite = favorite;
    });
  }

  Future<void> _toggleFavorite() async {
    await _favoriteService.toggleFavorite(widget.recipe);
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: Image.network(
                widget.recipe.image,
                width: double.infinity,
                height: 380,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Back button
          Positioned(
            top: 50,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.8),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF6A2E1F)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // Content container
          Positioned(
            top: 340,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(top: 4, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: ListView(
                children: [
                  // Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.recipe.name,
                          style: TextStyle(
                            fontFamily: 'comfortaa',
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF6A2E1F),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 1.5),
                        ),
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: _toggleFavorite,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Cal & Time
                  Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        size: 18,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${widget.recipe.calories} Cal/serve",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.access_time, size: 18, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        "${widget.recipe.totalTime} min",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.recipe.rating.toStringAsFixed(1)}/5",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "(${widget.recipe.reviewCount} Reviews)",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Ingredients Title
                  const Text(
                    "Ingredients",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A2E1F),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Ingredient List
                  for (int i = 0; i < widget.recipe.ingredients.length; i++)
                    buildlistItem(i, widget.recipe.ingredients[i]),

                  const SizedBox(height: 16),

                  // Instructions Title
                  const Text(
                    "Instructions",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A2E1F),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Instructions List
                  for (int i = 0; i < widget.recipe.instructions.length; i++)
                    buildlistItem(i, widget.recipe.instructions[i]),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0, onTap: (index) {}),
    );
  }

  Widget buildlistItem(int index, String ingredient) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align text to top if wrapped
        children: [
          Text(
            '${index + 1}. ',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Expanded(
            child: Text(
              ingredient,
              style: TextStyle(fontSize: 16, color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
