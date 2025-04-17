import 'package:flutter/material.dart';
import 'package:food_recipe_app/widgets/bottom_nav_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> categories = ['All', 'Dinner', 'Lunch', 'Breakfast'];
  String selectedCategory = 'All';

  List<Map<String, dynamic>> recipes = [
    {'title': 'Mexican Pizza', 'calories': 140, 'time': 25, 'favorite': true},
    {'title': 'Chicken Burger', 'calories': 140, 'time': 25, 'favorite': false},
    {'title': 'Mexican Pizza', 'calories': 140, 'time': 25, 'favorite': false},
    {'title': 'Mexican Pizza', 'calories': 140, 'time': 25, 'favorite': false},
    {'title': 'Mexican Pizza', 'calories': 140, 'time': 25, 'favorite': false},
    {'title': 'Mexican Pizza', 'calories': 140, 'time': 25, 'favorite': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF6EF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFDF6EF),
        elevation: 0,
        title: Text(
          'Food Recipes',
          style: TextStyle(
            fontFamily: 'comfortaa',
            color: Color(0xFF81230A),
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for any recipes',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Category Chips
            SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    categories.map((category) {
                      final isSelected = selectedCategory == category;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(color: Colors.transparent),
                          ),
                          label: Text(category),
                          selected: isSelected,
                          showCheckmark: false,
                          onSelected: (_) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          selectedColor: Color(0xFFFF6B2C),
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            SizedBox(height: 16),
            // Recipe Grid
            Expanded(
              child: GridView.builder(
                itemCount: recipes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 3.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Image placeholder + Favorite icon
                        Stack(
                          children: [
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              child: Icon(Icons.image, size: 50),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    recipe['favorite'] = !recipe['favorite'];
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    recipe['favorite']
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        recipe['favorite']
                                            ? Colors.red
                                            : Colors.grey,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title Text
                              Text(
                                recipe['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ), // Optional spacing between title and next section
                              // Row with icons and text
                              Row(
                                children: [
                                  Icon(Icons.local_fire_department, size: 14),
                                  SizedBox(width: 4),
                                  Text('${recipe['calories']} Cal'),
                                  SizedBox(width: 10),
                                  Icon(Icons.access_time, size: 14),
                                  SizedBox(width: 4),
                                  Text('${recipe['time']} min'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavBar(currentIndex: 0, onTap: (index) {}),
    );
  }
}
