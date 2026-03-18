import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 5;

  final List<String> _dietTypes = [
    "Vegetarian",
    "Vegan",
    "Keto",
    "Paleo",
    "Mediterranean",
    "Gluten-Free",
    "No Preference"
  ];

  final List<String> _allergies = [
    "Nuts",
    "Dairy",
    "Gluten",
    "Seafood",
    "Eggs",
    "Soy",
    "None"
  ];

  final List<String> _mealPreferences = [
    "Quick & Easy",
    "Low Calorie",
    "High Protein",
    "Budget-Friendly",
    "Gourmet",
    "Organic & Natural",
    "Any"
  ];

  String? _selectedDiet;
  final List<String> _selectedAllergies = [];
  String? _selectedMealPreference;
  int _calorieGoal = 2000;

  void _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (_selectedDiet != null) {
      await prefs.setString('diet_type', _selectedDiet!);
    }
    await prefs.setStringList('allergies', _selectedAllergies);
    if (_selectedMealPreference != null) {
      await prefs.setString('meal_preference', _selectedMealPreference!);
    }
    await prefs.setInt('calorie_goal', _calorieGoal);
    await prefs.setBool('questionnaire_completed', true);
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      // Save preferences and navigate to home screen
      _savePreferences();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tell Us About You"),
        leading: _currentPage > 0
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _previousPage,
        )
            : null,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Step ${_currentPage + 1} of $_totalPages",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: _totalPages,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey.shade300,
                    activeDotColor: const Color(0xFF4CAF50),
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 4,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildWelcomePage(screenSize),
                _buildDietTypePage(),
                _buildAllergiesPage(),
                _buildMealPreferencesPage(),
                _buildCalorieGoalPage(screenSize),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _currentPage == _totalPages - 1 ? "Finish" : "Continue",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomePage(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenSize.width * 0.3,
            height: screenSize.width * 0.3,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(screenSize.width * 0.15),
            ),
            child: Icon(
              Icons.restaurant_menu,
              size: screenSize.width * 0.18,
              color: const Color(0xFF4CAF50),
            ),
          ),
          SizedBox(height: screenSize.height * 0.04),
          Text(
            "Let's Get Started!",
            style: TextStyle(
              fontSize: screenSize.width * 0.065,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
          Text(
            "Answer a few questions to help us create the perfect meal plan for you.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenSize.width * 0.04,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDietTypePage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What type of diet do you follow?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Choose the option that best matches your eating habits.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: _dietTypes.length,
              itemBuilder: (context, index) {
                final diet = _dietTypes[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedDiet = diet;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _selectedDiet == diet
                            ? const Color(0xFF4CAF50).withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedDiet == diet
                              ? const Color(0xFF4CAF50)
                              : Colors.grey.shade300,
                          width: _selectedDiet == diet ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _selectedDiet == diet
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: _selectedDiet == diet
                                ? const Color(0xFF4CAF50)
                                : Colors.grey,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            diet,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: _selectedDiet == diet
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: _selectedDiet == diet
                                  ? Colors.black
                                  : Colors.grey[800],
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

  Widget _buildAllergiesPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Do you have any allergies?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Select all that apply.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: _allergies.length,
              itemBuilder: (context, index) {
                final allergy = _allergies[index];
                final isSelected = _selectedAllergies.contains(allergy);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedAllergies.remove(allergy);
                        } else {
                          if (allergy == "None") {
                            _selectedAllergies.clear();
                          } else {
                            _selectedAllergies.remove("None");
                          }
                          _selectedAllergies.add(allergy);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF4CAF50).withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF4CAF50)
                              : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: isSelected
                                ? const Color(0xFF4CAF50)
                                : Colors.grey,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            allergy,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                              color: isSelected ? Colors.black : Colors.grey[800],
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

  Widget _buildMealPreferencesPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What are your meal preferences?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Select the option that best matches your preferences.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: _mealPreferences.length,
              itemBuilder: (context, index) {
                final preference = _mealPreferences[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedMealPreference = preference;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _selectedMealPreference == preference
                            ? const Color(0xFF4CAF50).withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedMealPreference == preference
                              ? const Color(0xFF4CAF50)
                              : Colors.grey.shade300,
                          width: _selectedMealPreference == preference ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _selectedMealPreference == preference
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: _selectedMealPreference == preference
                                ? const Color(0xFF4CAF50)
                                : Colors.grey,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            preference,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: _selectedMealPreference == preference
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: _selectedMealPreference == preference
                                  ? Colors.black
                                  : Colors.grey[800],
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

  Widget _buildCalorieGoalPage(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What is your daily calorie goal?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Drag the slider to set your daily calorie target.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
          Center(
            child: Container(
              width: screenSize.width * 0.35,
              height: screenSize.width * 0.35,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF4CAF50),
                  width: 3,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _calorieGoal.toString(),
                      style: TextStyle(
                        fontSize: screenSize.width * 0.08,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4CAF50),
                      ),
                    ),
                    Text(
                      "calories",
                      style: TextStyle(
                        fontSize: screenSize.width * 0.035,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
          Slider(
            value: _calorieGoal.toDouble(),
            min: 1200,
            max: 3000,
            divisions: 36,
            activeColor: const Color(0xFF4CAF50),
            inactiveColor: Colors.grey.shade300,
            label: _calorieGoal.toString(),
            onChanged: (value) {
              setState(() {
                _calorieGoal = value.round();
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1200",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                "3000",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.03),
          const Text(
            "Note: Recommended daily calorie intake varies based on age, gender, weight, height, and activity level.",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}