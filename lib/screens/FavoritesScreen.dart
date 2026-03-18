import 'package:flutter/material.dart';
import 'MealDetailsScreen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<Map<String, dynamic>> _favoriteMeals = [
    {
      'id': '1',
      'name': 'Mediterranean Quinoa Bowl',
      'image': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
      'type': 'Lunch',
      'calories': 420,
      'time': '20 min',
      'rating': 4.7,
    },
    {
      'id': '2',
      'name': 'Avocado Toast with Poached Eggs',
      'image': 'https://images.pexels.com/photos/704569/pexels-photo-704569.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'type': 'Breakfast',
      'calories': 350,
      'time': '15 min',
      'rating': 4.5,
    },
    {
      'id': '3',
      'name': 'Grilled Salmon with Asparagus',
      'image': 'https://images.pexels.com/photos/3763847/pexels-photo-3763847.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'type': 'Dinner',
      'calories': 480,
      'time': '30 min',
      'rating': 4.8,
    },
    {
      'id': '4',
      'name': 'Berry Smoothie Bowl',
      'image': 'https://images.pexels.com/photos/1638280/pexels-photo-1638280.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'type': 'Breakfast',
      'calories': 320,
      'time': '10 min',
      'rating': 4.3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: _favoriteMeals.isEmpty
          ? _buildEmptyFavorites(screenSize)
          : _buildFavoritesList(screenSize),
    );
  }

  Widget _buildEmptyFavorites(Size screenSize) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // Added to prevent overflow
        children: [
          Icon(
            Icons.favorite_border,
            size: screenSize.width * 0.2,
            color: Colors.grey,
          ),
          SizedBox(height: screenSize.height * 0.02),
          Text(
            "No favorites yet",
            style: TextStyle(
              fontSize: screenSize.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Text(
            "Your favorite meals will appear here",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenSize.width * 0.035,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: screenSize.height * 0.03),
          ElevatedButton(
            onPressed: () {
              // Navigate to home screen
            },
            child: const Text("Explore Meals"),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(Size screenSize) {
    return Padding(
      padding: EdgeInsets.all(screenSize.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${_favoriteMeals.length} Meals",
            style: TextStyle(
              fontSize: screenSize.width * 0.035,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
          Expanded(
            child: ListView.builder(
              itemCount: _favoriteMeals.length,
              itemBuilder: (context, index) {
                final meal = _favoriteMeals[index];

                return Dismissible(
                  key: Key(meal['id']),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: screenSize.width * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: screenSize.width * 0.06,
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      _favoriteMeals.removeAt(index);
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${meal['name']} removed from favorites'),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            setState(() {
                              _favoriteMeals.insert(index, meal);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MealDetailsScreen(
                            mealId: meal['id'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: screenSize.height * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Meal image
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            child: Image.network(
                              meal['image'],
                              width: screenSize.width * 0.3,
                              height: screenSize.width * 0.3,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: screenSize.width * 0.3,
                                  height: screenSize.width * 0.3,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.image_not_supported, color: Colors.grey),
                                );
                              },
                            ),
                          ),
                          // Meal details
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(screenSize.width * 0.04),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Meal type
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenSize.width * 0.02,
                                      vertical: screenSize.height * 0.004,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      meal['type'],
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.025,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF4CAF50),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenSize.height * 0.008),
                                  // Meal name
                                  Text(
                                    meal['name'],
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.04,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: screenSize.height * 0.008),
                                  // Rating
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: screenSize.width * 0.04,
                                      ),
                                      SizedBox(width: screenSize.width * 0.01),
                                      Text(
                                        "${meal['rating']}",
                                        style: TextStyle(
                                          fontSize: screenSize.width * 0.035,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenSize.height * 0.008),
                                  // Additional info - Fixed overflow here
                                  Flexible(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.local_fire_department,
                                                size: screenSize.width * 0.035,
                                                color: Colors.orange,
                                              ),
                                              SizedBox(width: screenSize.width * 0.01),
                                              Flexible(
                                                child: Text(
                                                  "${meal['calories']} cal",
                                                  style: TextStyle(
                                                    fontSize: screenSize.width * 0.03,
                                                    color: Colors.grey[700],
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: screenSize.width * 0.03),
                                        Flexible(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                size: screenSize.width * 0.035,
                                                color: Colors.blue,
                                              ),
                                              SizedBox(width: screenSize.width * 0.01),
                                              Flexible(
                                                child: Text(
                                                  meal['time'],
                                                  style: TextStyle(
                                                    fontSize: screenSize.width * 0.03,
                                                    color: Colors.grey[700],
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Favorite button
                          Padding(
                            padding: EdgeInsets.all(screenSize.width * 0.02),
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: screenSize.width * 0.06,
                              ),
                              onPressed: () {
                                setState(() {
                                  _favoriteMeals.removeAt(index);
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${meal['name']} removed from favorites'),
                                    action: SnackBarAction(
                                      label: 'UNDO',
                                      onPressed: () {
                                        setState(() {
                                          _favoriteMeals.insert(index, meal);
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                              constraints: BoxConstraints(
                                minWidth: screenSize.width * 0.06,
                                minHeight: screenSize.width * 0.06,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}