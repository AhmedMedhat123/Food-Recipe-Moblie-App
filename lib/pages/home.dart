import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/model/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'package:food_recipe_app/widgets/bottom_nav_bar.dart';
import 'package:food_recipe_app/pages/recipe_detail_page.dart';
import 'package:food_recipe_app/services/favorite_service.dart';

class Home extends StatefulWidget {
  @override
  final bool focusSearch;
  const Home({this.focusSearch = false});

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> categories = ['All', 'Dinner', 'Lunch', 'Breakfast'];
  String selectedCategory = 'All';

  Set<String> favoriteIds = {};

  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  List<Recipe> recipes = [];
  List<Recipe> filteredRecipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecipes();
    fetchFavorites();

    _searchController.addListener(() {
      filterRecipes(selectedCategory);
    });

    if (widget.focusSearch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_searchFocusNode);
      });
    }
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchRecipes() async {
    final url = Uri.parse('https://dummyjson.com/recipes');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<Recipe> loadedRecipes =
            (data['recipes'] as List)
                .map((json) => Recipe.fromJson(json))
                .toList();
        setState(() {
          recipes = loadedRecipes;
          filteredRecipes = loadedRecipes;
          isLoading = false;
        });
      } else {
        print('Failed to load recipes');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchFavorites() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('favorites')
            .get();

    setState(() {
      favoriteIds = snapshot.docs.map((doc) => doc.id).toSet();
    });
  }

  void filterRecipes(String category) {
    setState(() {
      selectedCategory = category;
      searchQuery = _searchController.text.toLowerCase();

      filteredRecipes =
          recipes.where((recipe) {
            final matchesCategory =
                category == 'All' || recipe.mealType.contains(category);
            final matchesSearch = recipe.name.toLowerCase().contains(
              searchQuery,
            );
            return matchesCategory && matchesSearch;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F1),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF8F1),
        elevation: 0,
        automaticallyImplyLeading: false,
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
              focusNode: _searchFocusNode,
              controller: _searchController,
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
                            filterRecipes(category);
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
            isLoading
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : Expanded(
                  child: GridView.builder(
                    itemCount: filteredRecipes.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 3.5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final recipe = filteredRecipes[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the Recipe Detail page and pass the selected recipe
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => RecipeDetailPage(recipe: recipe),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Image + Favorite Icon
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
                                    child:
                                        recipe.image.isEmpty
                                            ? Icon(Icons.image, size: 50)
                                            : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                    top: Radius.circular(16),
                                                  ),
                                              child: Image.network(
                                                recipe.image,
                                                fit: BoxFit.cover,
                                                height: 140,
                                                width: double.infinity,
                                              ),
                                            ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () async {
                                        await FavoriteService().toggleFavorite(
                                          recipe,
                                        );
                                        await fetchFavorites(); // refresh UI with updated favorites
                                      },

                                      child: CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          favoriteIds.contains(
                                                recipe.id.toString(),
                                              )
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color:
                                              favoriteIds.contains(
                                                    recipe.id.toString(),
                                                  )
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
                                    Text(
                                      recipe.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.local_fire_department,
                                          size: 14,
                                        ),
                                        SizedBox(width: 4),
                                        Text('${recipe.calories} Cal'),
                                        SizedBox(width: 10),
                                        Icon(Icons.access_time, size: 14),
                                        SizedBox(width: 4),
                                        Text('${recipe.totalTime} min'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: widget.focusSearch ? 1 : 0,
        onTap: (index) {},
      ),
    );
  }
}
