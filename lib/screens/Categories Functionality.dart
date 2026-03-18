import 'package:flutter/material.dart';
import 'MealDetailsScreen.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryTitle;
  final Color categoryColor;

  const CategoryScreen({
    Key? key,
    required this.categoryTitle,
    required this.categoryColor,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<Map<String, dynamic>> _categoryMeals;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategoryMeals();
  }


  Future<void> _loadCategoryMeals() async {
    // Simulate API call to get meals for this category
    await Future.delayed(const Duration(seconds: 1));

    // Different meals based on category
    if (widget.categoryTitle == 'Breakfast') {
      _categoryMeals = [
        {
          'id': 'b1',
          'name': 'Avocado Toast with Poached Eggs',
          'image': 'https://images.unsplash.com/photo-1525351484163-7529414344d8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80',
          'description': 'Creamy avocado spread on whole grain toast topped with perfectly poached eggs and a sprinkle of red pepper flakes.',
          'calories': 350,
          'time': '15 min',
          'rating': 4.5,
          'ingredients': ['2 slices whole grain bread', '1 ripe avocado', '2 eggs', 'Salt and pepper to taste', 'Red pepper flakes (optional)'],
        },
        {
          'id': 'b2',
          'name': 'Greek Yogurt with Berries and Granola',
          'image': 'https://images.unsplash.com/photo-1488477181946-6428a0291777?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Creamy Greek yogurt topped with fresh mixed berries and crunchy granola.',
          'calories': 320,
          'time': '5 min',
          'rating': 4.3,
          'ingredients': ['1 cup Greek yogurt', '1/2 cup mixed berries', '1/4 cup granola', '1 tbsp honey'],
        },
        {
          'id': 'b3',
          'name': 'Spinach and Mushroom Omelette',
          'image': 'https://images.unsplash.com/photo-1490457843367-34b21b6ccd85?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Fluffy omelette filled with sautéed spinach, mushrooms, and cheese.',
          'calories': 320,
          'time': '15 min',
          'rating': 4.6,
          'ingredients': ['3 eggs', '1 cup spinach', '1/2 cup mushrooms', '1/4 cup cheese', 'Salt and pepper to taste'],
        },
        {
          'id': 'b4',
          'name': 'Whole Grain Pancakes with Maple Syrup',
          'image': 'https://images.unsplash.com/photo-1528207776546-365bb710ee93?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Fluffy whole grain pancakes served with fresh berries and pure maple syrup.',
          'calories': 450,
          'time': '20 min',
          'rating': 4.7,
          'ingredients': ['1 cup whole grain flour', '1 cup milk', '1 egg', '1 tbsp baking powder', '2 tbsp maple syrup'],
        },
      ];
    } else if (widget.categoryTitle == 'Lunch') {
      _categoryMeals = [
        {
          'id': 'l1',
          'name': 'Mediterranean Quinoa Bowl',
          'image': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Nutritious quinoa bowl with cherry tomatoes, cucumber, feta cheese, olives, and a lemon herb dressing.',
          'calories': 420,
          'time': '20 min',
          'rating': 4.7,
          'ingredients': ['1 cup quinoa', '1 cup cherry tomatoes', '1/2 cucumber', '1/4 cup feta cheese', '1/4 cup olives', '2 tbsp olive oil', '1 lemon'],
        },
        {
          'id': 'l2',
          'name': 'Chicken Caesar Salad',
          'image': 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Classic Caesar salad with grilled chicken breast, romaine lettuce, parmesan cheese, and homemade dressing.',
          'calories': 380,
          'time': '15 min',
          'rating': 4.5,
          'ingredients': ['2 cups romaine lettuce', '4 oz grilled chicken breast', '2 tbsp Caesar dressing', '2 tbsp parmesan cheese', 'Croutons'],
        },
        {
          'id': 'l3',
          'name': 'Vegetable Hummus Wrap',
          'image': 'https://images.unsplash.com/photo-1540420773420-3366772f4999?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Whole grain wrap filled with hummus, mixed greens, grated carrots, cucumber, and bell peppers.',
          'calories': 350,
          'time': '10 min',
          'rating': 4.4,
          'ingredients': ['1 whole grain wrap', '3 tbsp hummus', '1 cup mixed greens', '1/4 cup grated carrots', '1/4 cup sliced cucumber', '1/4 cup bell peppers'],
        },
      ];
    } else if (widget.categoryTitle == 'Dinner') {
      _categoryMeals = [
        {
          'id': 'd1',
          'name': 'Grilled Salmon with Asparagus',
          'image': 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Perfectly grilled salmon fillet with roasted asparagus spears and lemon herb butter.',
          'calories': 480,
          'time': '30 min',
          'rating': 4.8,
          'ingredients': ['6 oz salmon fillet', '1 bunch asparagus', '1 lemon', '2 tbsp butter', 'Fresh herbs', 'Salt and pepper to taste'],
        },
        {
          'id': 'd2',
          'name': 'Vegetable Stir Fry with Tofu',
          'image': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Colorful vegetable stir fry with crispy tofu in a savory ginger soy sauce.',
          'calories': 380,
          'time': '25 min',
          'rating': 4.6,
          'ingredients': ['8 oz firm tofu', 'Assorted vegetables', '2 tbsp soy sauce', '1 tbsp ginger', '2 cloves garlic', '1 tbsp sesame oil'],
        },
        {
          'id': 'd3',
          'name': 'Spaghetti with Homemade Tomato Sauce',
          'image': 'https://images.unsplash.com/photo-1556761223-4c4282c73f77?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Whole grain spaghetti with fresh homemade tomato sauce, basil, and parmesan cheese.',
          'calories': 450,
          'time': '35 min',
          'rating': 4.5,
          'ingredients': ['8 oz whole grain spaghetti', '2 cups tomato sauce', 'Fresh basil', '2 tbsp parmesan cheese', '2 cloves garlic', '1 tbsp olive oil'],
        },
      ];
    } else if (widget.categoryTitle == 'Snacks') {
      _categoryMeals = [
        {
          'id': 's1',
          'name': 'Apple with Almond Butter',
          'image': 'https://images.unsplash.com/photo-1488477181946-6428a0291777?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Sliced apple with a side of creamy almond butter for dipping.',
          'calories': 200,
          'time': '5 min',
          'rating': 4.2,
          'ingredients': ['1 apple', '2 tbsp almond butter'],
        },
        {
          'id': 's2',
          'name': 'Mixed Nuts and Dried Fruits',
          'image': 'https://images.unsplash.com/photo-1536304447766-da0ed4ce1b73?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'A nutritious mix of assorted nuts and dried fruits.',
          'calories': 250,
          'time': '0 min',
          'rating': 4.4,
          'ingredients': ['Almonds', 'Walnuts', 'Cashews', 'Dried cranberries', 'Dried apricots'],
        },
      ];
    } else if (widget.categoryTitle == 'Drinks') {
      _categoryMeals = [
        {
          'id': 'dr1',
          'name': 'Green Smoothie',
          'image': 'https://images.unsplash.com/photo-1557431170-c9fb990d21e3?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Nutrient-packed smoothie with spinach, banana, apple, and a hint of ginger.',
          'calories': 180,
          'time': '5 min',
          'rating': 4.6,
          'ingredients': ['1 cup spinach', '1 banana', '1/2 apple', '1 tsp ginger', '1 cup water'],
        },
        {
          'id': 'dr2',
          'name': 'Berry Protein Shake',
          'image': 'https://images.unsplash.com/photo-1536421464700-b43396707552?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Creamy protein shake with mixed berries, protein powder, and almond milk.',
          'calories': 220,
          'time': '5 min',
          'rating': 4.7,
          'ingredients': ['1 cup mixed berries', '1 scoop protein powder', '1 cup almond milk', '1/2 banana'],
        },
      ];
    } else {
      // Default category (Recipes)
      _categoryMeals = [
        {
          'id': 'r1',
          'name': 'Homemade Granola',
          'image': 'https://images.unsplash.com/photo-1517093157656-b9eccef01cb1?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Crunchy homemade granola with oats, nuts, seeds, and honey.',
          'calories': 300,
          'time': '40 min',
          'rating': 4.5,
          'ingredients': ['3 cups rolled oats', '1 cup mixed nuts', '1/2 cup seeds', '1/3 cup honey', '1/4 cup coconut oil'],
        },
        {
          'id': 'r2',
          'name': 'Veggie Lasagna',
          'image': 'https://images.unsplash.com/photo-1533777857889-4be7c70b33f7?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'description': 'Layered vegetable lasagna with zucchini, spinach, ricotta, and marinara sauce.',
          'calories': 420,
          'time': '60 min',
          'rating': 4.7,
          'ingredients': ['Lasagna noodles', 'Zucchini', 'Spinach', 'Ricotta cheese', 'Marinara sauce', 'Mozzarella cheese'],
        },
      ];
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryTitle),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildCategoryContent(screenSize),
    );
  }

  Widget _buildCategoryContent(Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category banner
        Container(
          width: double.infinity,
          height: screenSize.height * 0.15,
          margin: EdgeInsets.all(screenSize.width * 0.04),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: widget.categoryColor.withOpacity(0.2),
          ),
          child: Stack(
            children: [
              Positioned(
                right: screenSize.width * 0.04,
                top: screenSize.height * 0.025,
                child: Icon(
                  _getCategoryIcon(),
                  size: screenSize.width * 0.2,
                  color: widget.categoryColor.withOpacity(0.4),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenSize.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.categoryTitle,
                      style: TextStyle(
                        fontSize: screenSize.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: widget.categoryColor,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      "${_categoryMeals.length} items available",
                      style: TextStyle(
                        fontSize: screenSize.width * 0.035,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Meals list
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
          child: Text(
            "All ${widget.categoryTitle}",
            style: TextStyle(
              fontSize: screenSize.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: screenSize.height * 0.01),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(screenSize.width * 0.04),
            itemCount: _categoryMeals.length,
            itemBuilder: (context, index) {
              final meal = _categoryMeals[index];
              return GestureDetector(
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
                              // Meal type badge
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.02,
                                  vertical: screenSize.height * 0.004,
                                ),
                                decoration: BoxDecoration(
                                  color: widget.categoryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "${meal['time']} prep time",
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.025,
                                    fontWeight: FontWeight.w600,
                                    color: widget.categoryColor,
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
                              // Calories
                              Row(
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    size: screenSize.width * 0.035,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: screenSize.width * 0.01),
                                  Text(
                                    "${meal['calories']} cal",
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.03,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Arrow button
                      Padding(
                        padding: EdgeInsets.all(screenSize.width * 0.04),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: screenSize.width * 0.04,
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
    );
  }

  IconData _getCategoryIcon() {
    switch (widget.categoryTitle) {
      case 'Breakfast':
        return Icons.free_breakfast;
      case 'Lunch':
        return Icons.lunch_dining;
      case 'Dinner':
        return Icons.dinner_dining;
      case 'Snacks':
        return Icons.cake;
      case 'Drinks':
        return Icons.local_drink;
      default:
        return Icons.restaurant;
    }
  }
}