import 'package:flutter/material.dart';
import 'CartScreen.dart';

class MealDetailsScreen extends StatefulWidget {
  final String mealId;

  const MealDetailsScreen({
    Key? key,
    required this.mealId,
  }) : super(key: key);

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFavorite = false;
  late Map<String, dynamic> _meal;
  bool _isLoading = true;

  // Database of all available meals
  final List<Map<String, dynamic>> _allMeals = [
    {
      'id': '1',
      'name': 'Mediterranean Quinoa Bowl',
      'type': 'Lunch',
      'calories': 420,
      'protein': 15,
      'carbs': 62,
      'fat': 12,
      'time': '20 min',
      'servings': 1,
      'difficulty': 'Easy',
      'image': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
      'rating': 4.7,
      'reviews': 128,
      'description': 'A nutritious and delicious bowl packed with Mediterranean flavors. This colorful dish combines fluffy quinoa with fresh vegetables, feta cheese, and a zesty lemon dressing.',
      'ingredients': [
        {'name': 'Cooked quinoa', 'amount': '1 cup'},
        {'name': 'Cherry tomatoes', 'amount': '1/2 cup'},
        {'name': 'Cucumber', 'amount': '1/2 cup'},
        {'name': 'Red onion', 'amount': '1/4 cup'},
        {'name': 'Kalamata olives', 'amount': '1/4 cup'},
        {'name': 'Feta cheese', 'amount': '1/4 cup'},
        {'name': 'Olive oil', 'amount': '1 tbsp'},
        {'name': 'Lemon juice', 'amount': '1 tbsp'},
        {'name': 'Fresh parsley', 'amount': '2 tbsp'},
        {'name': 'Salt and pepper', 'amount': 'to taste'},
      ],
      'steps': [
        'Cook quinoa according to package instructions and let it cool.',
        'Dice cucumber, quarter cherry tomatoes, and finely chop red onion.',
        'Combine quinoa, vegetables, and olives in a bowl.',
        'Crumble feta cheese over the top.',
        'Mix olive oil, lemon juice, salt, and pepper to make the dressing.',
        'Pour dressing over the bowl and toss gently to combine.',
        'Garnish with fresh parsley before serving.'
      ],
      'price': 12.99,
      'reviewList': [
        {
          'username': 'Sarah J.',
          'rating': 5,
          'date': '2 weeks ago',
          'comment': 'This quinoa bowl is amazing! So fresh and flavorful. I added some grilled chicken to make it more filling.',
          'userImage': 'https://randomuser.me/api/portraits/women/44.jpg',
        },
        {
          'username': 'Mike T.',
          'rating': 4,
          'date': '1 month ago',
          'comment': 'Great healthy option for lunch. I would have liked a bit more dressing, but otherwise perfect!',
          'userImage': 'https://randomuser.me/api/portraits/men/32.jpg',
        },
        {
          'username': 'Emma L.',
          'rating': 5,
          'date': '2 months ago',
          'comment': 'Loved the Mediterranean flavors. Will definitely order again!',
          'userImage': 'https://randomuser.me/api/portraits/women/67.jpg',
        },
      ],
    },
    {
      'id': '2',
      'name': 'Avocado Toast with Poached Eggs',
      'type': 'Breakfast',
      'calories': 350,
      'protein': 18,
      'carbs': 35,
      'fat': 20,
      'time': '15 min',
      'servings': 1,
      'difficulty': 'Easy',
      'image': 'https://images.unsplash.com/photo-1525351484163-7529414344d8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80',
      'rating': 4.5,
      'reviews': 96,
      'description': 'A breakfast favorite with creamy avocado spread on toasted whole grain bread, topped with perfectly poached eggs and a sprinkle of red pepper flakes for a hint of heat.',
      'ingredients': [
        {'name': 'Whole grain bread', 'amount': '2 slices'},
        {'name': 'Ripe avocado', 'amount': '1'},
        {'name': 'Eggs', 'amount': '2'},
        {'name': 'Lemon juice', 'amount': '1 tsp'},
        {'name': 'Red pepper flakes', 'amount': '1/4 tsp'},
        {'name': 'Salt and pepper', 'amount': 'to taste'},
        {'name': 'Fresh cilantro', 'amount': '1 tbsp'},
      ],
      'steps': [
        'Toast the bread until golden and crispy.',
        'Cut the avocado in half, remove the pit, and scoop the flesh into a bowl.',
        'Mash the avocado with a fork and add lemon juice, salt, and pepper.',
        'Bring water to a gentle simmer for poaching eggs.',
        'Crack each egg into a small cup, then carefully slide into the water.',
        'Poach for 3-4 minutes until whites are set but yolks are still runny.',
        'Spread mashed avocado on toast, top with poached eggs, and sprinkle with red pepper flakes and cilantro.'
      ],
      'price': 10.99,
      'reviewList': [
        {
          'username': 'Jason K.',
          'rating': 5,
          'date': '1 week ago',
          'comment': 'Best avocado toast I\'ve ever had! The poached eggs were cooked to perfection.',
          'userImage': 'https://randomuser.me/api/portraits/men/22.jpg',
        },
        {
          'username': 'Lisa M.',
          'rating': 4,
          'date': '3 weeks ago',
          'comment': 'Delicious breakfast option. The bread was perfectly toasted and the avocado was creamy.',
          'userImage': 'https://randomuser.me/api/portraits/women/17.jpg',
        },
      ],
    },
    {
      'id': '3',
      'name': 'Grilled Salmon with Asparagus',
      'type': 'Dinner',
      'calories': 480,
      'protein': 32,
      'carbs': 25,
      'fat': 28,
      'time': '30 min',
      'servings': 1,
      'difficulty': 'Medium',
      'image': 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
      'rating': 4.8,
      'reviews': 152,
      'description': 'Perfectly grilled salmon fillet with tender-crisp asparagus spears. Seasoned with a delightful lemon herb butter that adds a bright and rich flavor to this healthy dinner option.',
      'ingredients': [
        {'name': 'Salmon fillet', 'amount': '6 oz'},
        {'name': 'Asparagus', 'amount': '10 spears'},
        {'name': 'Butter', 'amount': '2 tbsp'},
        {'name': 'Lemon', 'amount': '1'},
        {'name': 'Garlic', 'amount': '2 cloves'},
        {'name': 'Fresh dill', 'amount': '1 tbsp'},
        {'name': 'Olive oil', 'amount': '1 tbsp'},
        {'name': 'Salt and pepper', 'amount': 'to taste'},
      ],
      'steps': [
        'Preheat grill to medium-high heat.',
        'Trim the woody ends of the asparagus and toss with olive oil, salt, and pepper.',
        'Season salmon with salt and pepper on both sides.',
        'Make lemon herb butter by mixing softened butter with minced garlic, lemon zest, and chopped dill.',
        'Grill salmon skin-side down for 4-5 minutes, then flip and cook for another 3-4 minutes.',
        'Grill asparagus for 3-4 minutes, turning occasionally.',
        'Top the salmon with lemon herb butter and serve with asparagus and lemon wedges.'
      ],
      'price': 16.99,
      'reviewList': [
        {
          'username': 'Robert J.',
          'rating': 5,
          'date': '3 days ago',
          'comment': 'Absolutely delicious! The salmon was cooked perfectly and the lemon herb butter is to die for.',
          'userImage': 'https://randomuser.me/api/portraits/men/52.jpg',
        },
        {
          'username': 'Amanda P.',
          'rating': 5,
          'date': '2 weeks ago',
          'comment': 'My new favorite dinner! The asparagus was crisp and the salmon was moist and flavorful.',
          'userImage': 'https://randomuser.me/api/portraits/women/90.jpg',
        },
        {
          'username': 'David W.',
          'rating': 4,
          'date': '1 month ago',
          'comment': 'Great healthy dinner option. Would prefer a bit more seasoning, but overall very good.',
          'userImage': 'https://randomuser.me/api/portraits/men/61.jpg',
        },
        {
          'username': 'Jennifer L.',
          'rating': 5,
          'date': '2 months ago',
          'comment': 'Perfectly cooked salmon! The herb butter makes this dish special.',
          'userImage': 'https://randomuser.me/api/portraits/women/25.jpg',
        },
      ],
    },
    {
      'id': '4',
      'name': 'Berry Smoothie Bowl',
      'type': 'Breakfast',
      'calories': 320,
      'protein': 10,
      'carbs': 65,
      'fat': 5,
      'time': '10 min',
      'servings': 1,
      'difficulty': 'Easy',
      'image': 'https://images.unsplash.com/photo-1488477181946-6428a0291777?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
      'rating': 4.3,
      'reviews': 87,
      'description': 'A refreshing and nutrient-packed smoothie bowl loaded with antioxidant-rich berries. Topped with granola, fresh fruits, and a drizzle of honey for a perfect breakfast or snack.',
      'ingredients': [
        {'name': 'Frozen mixed berries', 'amount': '1 cup'},
        {'name': 'Banana', 'amount': '1'},
        {'name': 'Greek yogurt', 'amount': '1/2 cup'},
        {'name': 'Almond milk', 'amount': '1/4 cup'},
        {'name': 'Honey', 'amount': '1 tbsp'},
        {'name': 'Granola', 'amount': '1/4 cup'},
        {'name': 'Fresh berries', 'amount': '1/4 cup'},
        {'name': 'Chia seeds', 'amount': '1 tsp'},
      ],
      'steps': [
        'Blend frozen berries, banana, Greek yogurt, almond milk, and honey until smooth.',
        'Pour into a bowl. The consistency should be thicker than a regular smoothie.',
        'Top with granola, fresh berries, and chia seeds.',
        'Drizzle with additional honey if desired.',
        'Serve immediately.'
      ],
      'price': 9.99,
      'reviewList': [
        {
          'username': 'Laura T.',
          'rating': 4,
          'date': '1 week ago',
          'comment': 'Refreshing and delicious! Love the granola topping.',
          'userImage': 'https://randomuser.me/api/portraits/women/57.jpg',
        },
        {
          'username': 'Michael B.',
          'rating': 5,
          'date': '3 weeks ago',
          'comment': 'Perfect breakfast! Filling and healthy, with just the right amount of sweetness.',
          'userImage': 'https://randomuser.me/api/portraits/men/38.jpg',
        },
      ],
    },
    // Add more meal entries as needed
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadMealData();

    // Add listener to tab controller to rebuild when tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  Future<void> _loadMealData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Find the meal with the matching ID
    try {
      final foundMeal = _allMeals.firstWhere(
            (meal) => meal['id'] == widget.mealId,
        orElse: () => _allMeals[0], // Default to first meal if not found
      );

      setState(() {
        _meal = foundMeal;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading meal data: $e");
      setState(() {
        _meal = _allMeals[0]; // Default to first meal if error
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: const Color(0xFF4CAF50),
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
      SliverAppBar(
      expandedHeight: screenSize.height * 0.3,
        pinned: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(screenSize.width * 0.02),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: screenSize.width * 0.05,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(screenSize.width * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.black,
                size: screenSize.width * 0.05,
              ),
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });

              // Show confirmation message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isFavorite
                      ? '${_meal['name']} added to favorites'
                      : '${_meal['name']} removed from favorites'
                  ),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                  ),
                ),
              );
            },
          ),
          SizedBox(width: screenSize.width * 0.04),
        ],
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                _meal['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported, color: Colors.grey),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.7, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Row(
          children: [
          Container(
          padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.03,
            vertical: screenSize.height * 0.006,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _meal['type'],
            style: TextStyle(
              fontSize: screenSize.width * 0.03,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4CAF50),
            ),
          ),
        ),
        const Spacer(),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: screenSize.width * 0.045,
        ),
        SizedBox(width: screenSize.width * 0.01),
        Text(
          "${_meal['rating']}",
          style: TextStyle(
            fontSize: screenSize.width * 0.035,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: screenSize.width * 0.01),
        Text(
          "(${_meal['reviews']} reviews)",
          style: TextStyle(
            fontSize: screenSize.width * 0.03,
            color: Colors.grey[600],
          ),
        ),
        ],
      ),
      SizedBox(height: screenSize.height * 0.015),
      Text(
        _meal['name'],
        style: TextStyle(
          fontSize: screenSize.width * 0.06,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: screenSize.height * 0.005),
      Row(
        children: [
          Icon(
            Icons.access_time,
            size: screenSize.width * 0.04,
            color: Colors.blue,
          ),
          SizedBox(width: screenSize.width * 0.01),
          Text(
            _meal['time'],
            style: TextStyle(
              fontSize: screenSize.width * 0.035,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(width: screenSize.width * 0.04),
          Icon(
            Icons.food_bank_outlined,
            size: screenSize.width * 0.04,
            color: Colors.orange,
          ),
          SizedBox(width: screenSize.width * 0.01),
          Text(
            "${_meal['servings']} serving${_meal['servings'] != 1 ? 's' : ''}",
            style: TextStyle(
              fontSize: screenSize.width * 0.035,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(width: screenSize.width * 0.04),
          Icon(
            Icons.equalizer,
            size: screenSize.width * 0.04,
            color: Colors.purple,
          ),
          SizedBox(width: screenSize.width * 0.01),
          Text(
            _meal['difficulty'],
            style: TextStyle(
              fontSize: screenSize.width * 0.035,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
      SizedBox(height: screenSize.height * 0.02),
      Container(
        padding: EdgeInsets.all(screenSize.width * 0.04),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNutrientInfo(
              value: "${_meal['calories']}",
              unit: "cal",
              label: "Calories",
              color: Colors.red,
              screenSize: screenSize,
            ),
            _buildNutrientInfo(
              value: "${_meal['protein']}",
              unit: "g",
              label: "Protein",
              color: Colors.blue,
              screenSize: screenSize,
            ),
            _buildNutrientInfo(
              value: "${_meal['carbs']}",
              unit: "g",
              label: "Carbs",
              color: Colors.orange,
              screenSize: screenSize,
            ),
            _buildNutrientInfo(
              value: "${_meal['fat']}",
              unit: "g",
              label: "Fat",
              color: Colors.purple,
              screenSize: screenSize,
            ),
          ],
        ),
      ),
      SizedBox(height: screenSize.height * 0.03),
      Text(
        "Description",
        style: TextStyle(
          fontSize: screenSize.width * 0.045,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: screenSize.height * 0.01),
      Text(
        _meal['description'],
        style: TextStyle(
          fontSize: screenSize.width * 0.035,
          color: Colors.grey[700],
          height: 1.5,
        ),
      ),
      SizedBox(height: screenSize.height * 0.03),
      Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF4CAF50),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[700],
          labelStyle: TextStyle(
            fontSize: screenSize.width * 0.035,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: screenSize.width * 0.035,
            fontWeight: FontWeight.w500,
          ),
          tabs: const [
            Tab(text: "Ingredients"),
            Tab(text: "Instructions"),
            Tab(text: "Reviews"),
          ],
        ),
      ),
      SizedBox(height: screenSize.height * 0.02),
      SizedBox(
        height: _tabController.index == 2 && _meal.containsKey('reviewList') && _meal['reviewList'].length > 2
            ? screenSize.height * 0.5  // Make taller for reviews tab
            : screenSize.height * 0.35, // Normal height for other tabs
        child: TabBarView(
            controller: _tabController,
            children: [
        // Ingredients tab
        ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _meal['ingredients'].length,
        itemBuilder: (context, index) {
          final ingredient = _meal['ingredients'][index];
          return Padding(
            padding: EdgeInsets.only(bottom: screenSize.height * 0.015),
            child: Row(
              children: [
                Container(
                  width: screenSize.width * 0.02,
                  height: screenSize.width * 0.02,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                SizedBox(width: screenSize.width * 0.03),
                Expanded(
                  child: Text(
                    ingredient['name'],
                    style: TextStyle(
                      fontSize: screenSize.width * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  ingredient['amount'],
                  style: TextStyle(
                    fontSize: screenSize.width * 0.035,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          );
        },
      ),

      // Instructions tab
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _meal['steps'].length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: screenSize.height * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenSize.width * 0.06,
                  height: screenSize.width * 0.06,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF4CAF50),
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.width * 0.035,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width * 0.03),
                Expanded(
                  child: Text(
                    _meal['steps'][index],
                    style: TextStyle(
                      fontSize: screenSize.width * 0.035,
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      // Reviews tab
      _meal.containsKey('reviewList') && _meal['reviewList'].length > 0
          ? ListView(
          physics: const BouncingScrollPhysics(),
          children: [
      // Reviews summary
      Container(
      padding: EdgeInsets.all(screenSize.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: screenSize.width * 0.15,
            height: screenSize.width * 0.15,
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "${_meal['rating']}",
                style: TextStyle(
                  fontSize: screenSize.width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
          ),
          SizedBox(width: screenSize.width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRatingBar(_meal['rating'], screenSize),
                SizedBox(height: screenSize.height * 0.01),
                Text(
                  "Based on ${_meal['reviews']} reviews",
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
    SizedBox(height: screenSize.height * 0.02),
            // Write a review button
            ElevatedButton.icon(
              onPressed: () => _showReviewDialog(context, screenSize),
              icon: Icon(Icons.rate_review, size: screenSize.width * 0.04),
              label: Text(
                "Write a Review",
                style: TextStyle(
                  fontSize: screenSize.width * 0.035,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.015,
                  horizontal: screenSize.width * 0.03,
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),

            // Individual reviews
            ...List.generate(
              _meal['reviewList'].length,
                  (index) => _buildReviewItem(_meal['reviewList'][index], screenSize),
            ),
          ],
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star_border,
              size: screenSize.width * 0.15,
              color: Colors.grey,
            ),
            SizedBox(height: screenSize.height * 0.02),
            Text(
              "No reviews yet",
              style: TextStyle(
                fontSize: screenSize.width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            Text(
              "Be the first to review this meal",
              style: TextStyle(
                fontSize: screenSize.width * 0.035,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            ElevatedButton(
              onPressed: () => _showReviewDialog(context, screenSize),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.015,
                  horizontal: screenSize.width * 0.03,
                ),
              ),
              child: Text(
                "Write a Review",
                style: TextStyle(
                  fontSize: screenSize.width * 0.035,
                ),
              ),
            ),
          ],
        ),
      ),
            ],
        ),
      ),
              SizedBox(height: screenSize.height * 0.02),
            ],
          ),
        ),
      ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(screenSize.width * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.03,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "\$${_meal['price'].toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
            SizedBox(width: screenSize.width * 0.04),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientInfo({
    required String value,
    required String unit,
    required String label,
    required Color color,
    required Size screenSize,
  }) {
    return Column(
      children: [
        Container(
          width: screenSize.width * 0.15,
          height: screenSize.width * 0.15,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      fontSize: screenSize.width * 0.04,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  TextSpan(
                    text: unit,
                    style: TextStyle(
                      fontSize: screenSize.width * 0.03,
                      fontWeight: FontWeight.w400,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: screenSize.height * 0.01),
        Text(
          label,
          style: TextStyle(
            fontSize: screenSize.width * 0.03,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBar(double rating, Size screenSize) {
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      children: [
        ...List.generate(
          fullStars,
              (index) => Icon(
            Icons.star,
            color: Colors.amber,
            size: screenSize.width * 0.05,
          ),
        ),
        if (hasHalfStar)
          Icon(
            Icons.star_half,
            color: Colors.amber,
            size: screenSize.width * 0.05,
          ),
        ...List.generate(
          emptyStars,
              (index) => Icon(
            Icons.star_border,
            color: Colors.amber,
            size: screenSize.width * 0.05,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review, Size screenSize) {
    return Container(
      margin: EdgeInsets.only(bottom: screenSize.height * 0.02),
      padding: EdgeInsets.all(screenSize.width * 0.04),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // User avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(screenSize.width * 0.06),
                child: Image.network(
                  review['userImage'],
                  width: screenSize.width * 0.12,
                  height: screenSize.width * 0.12,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: screenSize.width * 0.12,
                      height: screenSize.width * 0.12,
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: screenSize.width * 0.06,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: screenSize.width * 0.03),
              // Username and rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['username'],
                      style: TextStyle(
                        fontSize: screenSize.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.005),
                    Row(
                      children: [
                        ...List.generate(
                          review['rating'],
                              (index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: screenSize.width * 0.035,
                          ),
                        ),
                        ...List.generate(
                          5 - (review['rating'] as num).toInt(),  // Convert to int
                              (index) => Icon(
                            Icons.star_border,
                            color: Colors.amber,
                            size: screenSize.width * 0.035,
                          ),
                        ),
                        SizedBox(width: screenSize.width * 0.02),
                        Text(
                          review['date'],
                          style: TextStyle(
                            fontSize: screenSize.width * 0.03,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.015),
          // Review text
          Text(
            review['comment'],
            style: TextStyle(
              fontSize: screenSize.width * 0.035,
              color: Colors.grey[800],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  void _showReviewDialog(BuildContext context, Size screenSize) {
    int _userRating = 5;
    final TextEditingController _reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Write a Review'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "How would you rate this meal?",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.035,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: screenSize.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _userRating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: screenSize.width * 0.06,
                      ),
                      onPressed: () {
                        setState(() {
                          _userRating = index + 1;
                        });
                      },
                    );
                  }),
                ),
                SizedBox(height: screenSize.height * 0.02),
                TextField(
                  controller: _reviewController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Share your experience with this meal...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: EdgeInsets.all(screenSize.width * 0.03),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Submit review logic would go here
                // For now, just close dialog and show confirmation
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Thank you for your review!'),
                    backgroundColor: Color(0xFF4CAF50),
                  ),
                );

                // In a real app, you would add the new review to the list
                // and update the average rating
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
              ),
              child: const Text('Submit'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}