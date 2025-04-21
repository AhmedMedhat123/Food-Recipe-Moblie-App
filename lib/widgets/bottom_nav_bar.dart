import 'package:flutter/material.dart';
import 'package:food_recipe_app/pages/home.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Home(focusSearch: true)),
          );
        } else if (index == 3) {
          Navigator.pushReplacementNamed(context, '/favorites');
        } else {
          onTap(index);
        }
      },

      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search, size: 30), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.add_box, size: 30), label: ''),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, size: 30),
          label: '',
        ),
      ],
    );
  }
}
