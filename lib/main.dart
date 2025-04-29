import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_recipe_app/pages/favorite_page.dart';
import 'package:food_recipe_app/pages/home.dart';
import 'package:food_recipe_app/pages/login.dart';
import 'package:food_recipe_app/pages/recipe_detail_page.dart';
import 'firebase_options.dart';
import 'package:food_recipe_app/pages/register.dart';
import 'package:food_recipe_app/pages/add_recipe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => Home(),
        '/favorites': (context) => FavoritePage(),
        '/register': (context) => Register(),
        '/add_recipe': (context) => AddRecipe(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
