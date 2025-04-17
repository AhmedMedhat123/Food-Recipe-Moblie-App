import 'package:flutter/material.dart';
import 'package:food_recipe_app/widgets/bottom_nav_bar.dart';

class FavoritePage extends StatelessWidget {
  final List<Map<String, String>> favorites = List.generate(
    4,
    (index) => {
      'image': 'assets/images/steak.jpg',
      'title': 'Beef Steak',
      'calories': '140 Cal',
      'time': '25 min',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E9), // light peach background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6A2E1F)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Favorite',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF81230A),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final item = favorites[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item['image']!,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['calories']!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['time']!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Handle delete
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}
