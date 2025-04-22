import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_recipe_app/widgets/bottom_nav_bar.dart';

class AddRecipe extends StatefulWidget {
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _cookTimeController = TextEditingController();
  final _servingsController = TextEditingController();
  final _imageController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _cuisineController = TextEditingController();

  final _ingredientController = TextEditingController();
  final _instructionController = TextEditingController();
  final _tagController = TextEditingController();
  final _mealTypeController = TextEditingController();

  List<String> ingredients = [];
  List<String> instructions = [];
  List<String> tags = [];
  List<String> mealTypes = [];

  Future<void> _submitRecipe() async {
    if (_formKey.currentState!.validate()) {
      final recipeData = {
        "id": DateTime.now().millisecondsSinceEpoch,
        "name": _nameController.text.trim(),
        "ingredients": ingredients,
        "instructions": instructions,
        "prepTimeMinutes": int.tryParse(_prepTimeController.text) ?? 0,
        "cookTimeMinutes": int.tryParse(_cookTimeController.text) ?? 0,
        "servings": int.tryParse(_servingsController.text) ?? 0,
        "difficulty": "Easy",
        "cuisine": _cuisineController.text.trim(),
        "caloriesPerServing": int.tryParse(_caloriesController.text) ?? 0,
        "tags": tags,
        "userId": 166,
        "image": _imageController.text.trim(),
        "rating": 0,
        "reviewCount": 0,
        "mealType": mealTypes,
      };

      await FirebaseFirestore.instance.collection('recipes').add(recipeData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recipe added!'),
          backgroundColor: Color(0xFFFF6B2C),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F1),
      appBar: AppBar(
        centerTitle: true,

        title: Text(
          'Add Recipe',
          style: TextStyle(
            fontFamily: 'comfortaa',
            color: Color(0xFF81230A),
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Color(0xFFFFF8F1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF81230A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipe Name
              _buildTextField(_nameController, 'Recipe Name'),
              SizedBox(height: 16),

              // Image URL
              _buildTextField(_imageController, 'Image URL'),
              SizedBox(height: 16),

              // Time and Servings Row
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      _prepTimeController,
                      'Prep Time (min)',
                      isNumber: true,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      _cookTimeController,
                      'Cook Time (min)',
                      isNumber: true,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      _servingsController,
                      'Servings',
                      isNumber: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Calories and Cuisine
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      _caloriesController,
                      'Calories Per Serving',
                      isNumber: true,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(_cuisineController, 'Cuisine'),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Ingredients Section
              _buildListSection(
                title: 'Ingredients',
                list: ingredients,
                controller: _ingredientController,
                onAdd: () {
                  if (_ingredientController.text.isNotEmpty) {
                    setState(() {
                      ingredients.add(_ingredientController.text.trim());
                      _ingredientController.clear();
                    });
                  }
                },
                onRemove: (index) {
                  setState(() {
                    ingredients.removeAt(index);
                  });
                },
              ),
              SizedBox(height: 24),

              // Instructions Section
              _buildListSection(
                title: 'Instructions',
                list: instructions,
                controller: _instructionController,
                onAdd: () {
                  if (_instructionController.text.isNotEmpty) {
                    setState(() {
                      instructions.add(_instructionController.text.trim());
                      _instructionController.clear();
                    });
                  }
                },
                onRemove: (index) {
                  setState(() {
                    instructions.removeAt(index);
                  });
                },
              ),
              SizedBox(height: 24),

              // Tags Section
              _buildListSection(
                title: 'Tags',
                list: tags,
                controller: _tagController,
                onAdd: () {
                  if (_tagController.text.isNotEmpty) {
                    setState(() {
                      tags.add(_tagController.text.trim());
                      _tagController.clear();
                    });
                  }
                },
                onRemove: (index) {
                  setState(() {
                    tags.removeAt(index);
                  });
                },
              ),
              SizedBox(height: 24),

              // Meal Types Section
              _buildListSection(
                title: 'Meal Types',
                list: mealTypes,
                controller: _mealTypeController,
                onAdd: () {
                  if (_mealTypeController.text.isNotEmpty) {
                    setState(() {
                      mealTypes.add(_mealTypeController.text.trim());
                      _mealTypeController.clear();
                    });
                  }
                },
                onRemove: (index) {
                  setState(() {
                    mealTypes.removeAt(index);
                  });
                },
              ),
              SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitRecipe,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6B2C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'ADD RECIPE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2, onTap: (index) {}),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isNumber = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF81230A),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) return 'Required';
            if (isNumber && int.tryParse(value) == null)
              return 'Enter a valid number';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildListSection({
    required String title,
    required List<String> list,
    required TextEditingController controller,
    required VoidCallback onAdd,
    required Function(int) onRemove,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xFF81230A),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Add $title',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFF6B2C),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: onAdd,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        ...List.generate(list.length, (index) {
          return Container(
            margin: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              title: Text(list[index]),
              trailing: IconButton(
                icon: Icon(Icons.close, color: Colors.grey),
                onPressed: () => onRemove(index),
              ),
            ),
          );
        }),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _prepTimeController.dispose();
    _cookTimeController.dispose();
    _servingsController.dispose();
    _imageController.dispose();
    _caloriesController.dispose();
    _cuisineController.dispose();
    _ingredientController.dispose();
    _instructionController.dispose();
    _tagController.dispose();
    _mealTypeController.dispose();
    super.dispose();
  }
}
