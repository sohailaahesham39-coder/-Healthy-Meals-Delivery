import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CartScreen.dart';
import 'Categories Functionality.dart';
import 'FavoritesScreen.dart';
import 'MealDetailsScreen.dart';
import 'Notifications.dart';
import 'Order.dart';
import 'SettingsScreen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _userName = "User";
  String? _userPhotoUrl;
  bool _hasUnreadNotifications = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _checkNotifications();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? "User";
      _userPhotoUrl = prefs.getString('userPhoto');
    });
  }

  Future<void> _checkNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasUnreadNotifications = prefs.getBool('hasUnreadNotifications') ?? true;
    });
  }

  final List<Map<String, dynamic>> _promotionBanners = [
    {
      'title': '20% OFF',
      'subtitle': 'On your first order',
      'image': 'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?ixlib=rb-1.2.1&auto=format&fit=crop&w=300&q=80',
      'color1': const Color(0xFF4CAF50),
      'color2': const Color(0xFF66BB6A),
    },
    {
      'title': 'Free Delivery',
      'subtitle': 'On orders over \$20',
      'image': 'https://images.unsplash.com/photo-1505253758473-96b7015fcd40?ixlib=rb-1.2.1&auto=format&fit=crop&w=300&q=80',
      'color1': const Color(0xFF2196F3),
      'color2': const Color(0xFF64B5F6),
    },
    {
      'title': 'New Recipes',
      'subtitle': 'Check out our spring collection',
      'image': 'https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-1.2.1&auto=format&fit=crop&w=300&q=80',
      'color1': const Color(0xFFFF9800),
      'color2': const Color(0xFFFFB74D),
    },
  ];

  final List<Map<String, dynamic>> _mealPlans = [
    {
      'title': 'Today\'s Plan',
      'date': 'March 24, 2025',
      'calories': 2000,
      'meals': [
        {
          'type': 'Breakfast',
          'name': 'Avocado Toast with Poached Eggs',
          'calories': 450,
          'image': 'https://images.unsplash.com/photo-1525351484163-7529414344d8?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'time': '20 min',
        },
        {
          'type': 'Lunch',
          'name': 'Mediterranean Quinoa Bowl',
          'calories': 650,
          'image': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'time': '25 min',
        },
        {
          'type': 'Dinner',
          'name': 'Grilled Salmon with Asparagus',
          'calories': 550,
          'image': 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'time': '30 min',
        },
        {
          'type': 'Snack',
          'name': 'Greek Yogurt with Berries',
          'calories': 200,
          'image': 'https://images.unsplash.com/photo-1488477181946-6428a0291777?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'time': '5 min',
        },
      ],
    },
    {
      'title': 'Tomorrow\'s Plan',
      'date': 'March 25, 2025',
      'calories': 2100,
      'meals': [
        {
          'type': 'Breakfast',
          'name': 'Spinach and Mushroom Omelette',
          'calories': 420,
          'image': 'https://images.unsplash.com/photo-1490457843367-34b21b6ccd85?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'time': '15 min',
        },
        {
          'type': 'Lunch',
          'name': 'Chicken Caesar Salad',
          'calories': 550,
          'image': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'time': '20 min',
        },
        {
          'type': 'Dinner',
          'name': 'Vegetable Stir Fry with Tofu',
          'calories': 480,
          'image': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'time': '25 min',
        },
        {
          'type': 'Snack',
          'name': 'Apple with Almond Butter',
          'calories': 180,
          'image': 'https://images.unsplash.com/photo-1488477181946-6428a0291777?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
          'time': '5 min',
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> _categories = [
    {
      'icon': Icons.free_breakfast,
      'title': 'Breakfast',
      'color': Colors.orange,
    },
    {
      'icon': Icons.lunch_dining,
      'title': 'Lunch',
      'color': Colors.blue,
    },
    {
      'icon': Icons.dinner_dining,
      'title': 'Dinner',
      'color': Colors.purple,
    },
    {
      'icon': Icons.cake,
      'title': 'Snacks',
      'color': Colors.pink,
    },
    {
      'icon': Icons.local_drink,
      'title': 'Drinks',
      'color': Colors.teal,
    },
    {
      'icon': Icons.restaurant,
      'title': 'Recipes',
      'color': Colors.amber,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildHomeTab(screenSize),
            const CartScreen(),
            const OrdersScreen(),
            const FavoritesScreen(),
            const SettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(51),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF4CAF50),
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                activeIcon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                activeIcon: Icon(Icons.receipt_long),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeTab(Size screenSize) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(screenSize.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Hello, ${_userName.split(' ')[0]}!",
                      style: TextStyle(
                        fontSize: screenSize.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.005),
                    Text(
                      "Let's plan your meals today",
                      style: TextStyle(
                        fontSize: screenSize.width * 0.035,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(26),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationsScreen(),
                            ),
                          ).then((_) => _checkNotifications());
                        },
                      ),
                      if (_hasUnreadNotifications)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Promotion Banners Carousel
          CarouselSlider.builder(
            itemCount: _promotionBanners.length,
            options: CarouselOptions(
              height: screenSize.height * 0.20,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              enableInfiniteScroll: true,
            ),
            itemBuilder: (context, index, _) {
              final banner = _promotionBanners[index];
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [banner['color1'], banner['color2']],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      bottom: -10,
                      child: Image.network(
                        banner['image'],
                        width: screenSize.width * 0.35,
                        height: screenSize.height * 0.15,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenSize.width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            banner['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenSize.width * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.005),
                          Text(
                            banner['subtitle'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenSize.width * 0.035,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.015),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: banner['color1'],
                              padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.035,
                                vertical: screenSize.height * 0.01,
                              ),
                            ),
                            child: const Text("Order Now"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: screenSize.height * 0.025),

          // Meal Plans Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Meal Plans",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: screenSize.height * 0.01),

          // Meal Plan Carousel
          SizedBox(
            height: screenSize.height * 0.32,
            child: CarouselSlider.builder(
              itemCount: _mealPlans.length,
              options: CarouselOptions(
                height: screenSize.height * 0.32,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
              ),
              itemBuilder: (context, index, realIndex) {
                final mealPlan = _mealPlans[index];
                return Container(
                  margin: EdgeInsets.only(right: screenSize.width * 0.025),
                  padding: EdgeInsets.all(screenSize.width * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(26),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                mealPlan['title'],
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.004),
                              Text(
                                mealPlan['date'],
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.03,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.02,
                              vertical: screenSize.height * 0.005,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50).withAlpha(26),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  size: screenSize.width * 0.035,
                                  color: const Color(0xFF4CAF50),
                                ),
                                SizedBox(width: screenSize.width * 0.01),
                                Text(
                                  "${mealPlan['calories']} cal",
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.03,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF4CAF50),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      Row(
                        children: List.generate(
                          mealPlan['meals'].length,
                              (mealIndex) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MealDetailsScreen(
                                      mealId: "${index}_$mealIndex",
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: mealIndex < 3 ? screenSize.width * 0.02 : 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: screenSize.height * 0.06,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            mealPlan['meals'][mealIndex]['image'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screenSize.height * 0.005),
                                    Text(
                                      mealPlan['meals'][mealIndex]['type'],
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.025,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: screenSize.height * 0.002),
                                    Text(
                                      "${mealPlan['meals'][mealIndex]['calories']} cal",
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.025,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF4CAF50),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.008,
                              horizontal: screenSize.width * 0.04,
                            ),
                          ),
                          child: Text(
                            "View Details",
                            style: TextStyle(fontSize: screenSize.width * 0.03),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: screenSize.height * 0.03),

          // Categories Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: screenSize.width * 0.04,
                    mainAxisSpacing: screenSize.width * 0.04,
                  ),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return _buildCategoryItem(
                      icon: _categories[index]['icon'],
                      title: _categories[index]['title'],
                      color: _categories[index]['color'],
                      screenSize: screenSize,
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: screenSize.height * 0.03),

          // Recommended Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommended For You",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: screenSize.height * 0.01),

          SizedBox(
            height: screenSize.height * 0.24,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
              scrollDirection: Axis.horizontal,
              itemCount: _mealPlans[0]['meals'].length,
              itemBuilder: (context, index) {
                final meal = _mealPlans[0]['meals'][index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MealDetailsScreen(
                          mealId: "recommended_$index",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: screenSize.width * 0.4,
                    margin: EdgeInsets.only(right: screenSize.width * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(26),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: Image.network(
                            meal['image'],
                            width: double.infinity,
                            height: screenSize.height * 0.13,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenSize.width * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.02,
                                  vertical: screenSize.height * 0.004,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4CAF50).withAlpha(26),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  meal['type'],
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.025,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF4CAF50),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.006),
                              Text(
                                meal['name'],
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.035,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: screenSize.height * 0.004),
                              Text(
                                "${meal['calories']} cal • ${meal['time']}",
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.03,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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

          SizedBox(height: screenSize.height * 0.03),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({
    required IconData icon,
    required String title,
    required Color color,
    required Size screenSize,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              categoryTitle: title,
              categoryColor: color,
            ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: screenSize.width * 0.16,
            height: screenSize.width * 0.16,
            decoration: BoxDecoration(
              color: color.withAlpha(26),
              borderRadius: BorderRadius.circular(screenSize.width * 0.04),
            ),
            child: Icon(
              icon,
              color: color,
              size: screenSize.width * 0.075,
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Text(
            title,
            style: TextStyle(
              fontSize: screenSize.width * 0.035,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}