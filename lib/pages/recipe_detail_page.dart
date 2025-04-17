import 'package:flutter/material.dart';
import 'package:food_recipe_app/widgets/bottom_nav_bar.dart';

class RecipeDetailPage extends StatefulWidget {
  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  int servings = 1;

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
              child: Image.asset(
                'assets/images/steak.jpg',
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
                      const Text(
                        "Beef Steak",
                        style: TextStyle(
                          fontFamily: 'comfortaa',
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF6A2E1F),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 1.5),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Cal & Time
                  Row(
                    children: const [
                      Icon(
                        Icons.local_fire_department,
                        size: 18,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 4),
                      Text("140 Cal", style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 16),
                      Icon(Icons.access_time, size: 18, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("25 min", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Rating
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 4),
                      Text(
                        "4.5/5",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "(20 Reviews)",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Ingredients Title
                  const Text(
                    "Ingredients",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A2E1F),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "How many servings?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (servings > 1) servings--;
                                });
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              servings.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  servings++;
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Ingredient List
                  buildIngredientItem("assets/images/beef.jpeg", "Beef", 800.0),
                  buildIngredientItem(
                    "assets/images/vegetables.jpg",
                    "Vegetables",
                    200.0,
                  ),
                  buildIngredientItem("assets/images/beef.jpeg", "Beef", 800.0),
                  buildIngredientItem(
                    "assets/images/vegetables.jpg",
                    "Vegetables",
                    200.0,
                  ),
                  buildIngredientItem("assets/images/beef.jpeg", "Beef", 800.0),
                  buildIngredientItem("assets/images/beef.jpeg", "Beef", 800.0),
                  buildIngredientItem("assets/images/beef.jpeg", "Beef", 800.0),
                  buildIngredientItem("assets/images/beef.jpeg", "Beef", 800.0),
                  buildIngredientItem("assets/images/beef.jpeg", "Beef", 800.0),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0, onTap: (index) {}),
    );
  }

  Widget buildIngredientItem(String icon, String name, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Image.asset(icon, width: 40, height: 40),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: const TextStyle(fontSize: 16))),
          Text(
            "${(amount * servings / 2).toStringAsFixed(1)}gm",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
