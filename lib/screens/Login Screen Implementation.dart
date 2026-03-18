import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Questionnaire Screen Implementation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // Email/Password Login
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));

      // Extract first name for a better user experience
      String email = _emailController.text;
      String firstName = email.split('@')[0]; // Simple extraction from email
      firstName = firstName.split('.').first; // Remove if email has dots
      // Capitalize first letter
      firstName = firstName[0].toUpperCase() + firstName.substring(1);

      // Save login state and user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userName', firstName); // Store first name
      await prefs.setString('userEmail', email);

      // Navigate to questionnaire screen
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const QuestionnaireScreen(),
          ),
        );
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Register account
  Future<void> _register() async {
    if (!_registerFormKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate registration process
      await Future.delayed(const Duration(seconds: 2));

      // Get full name and extract first name
      String fullName = _nameController.text.trim();
      String firstName = fullName.split(' ')[0]; // Extract first name

      // Save login state and user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userName', fullName); // Store full name
      await prefs.setString('userFirstName', firstName); // Store first name separately
      await prefs.setString('userEmail', _emailController.text);

      // Navigate to questionnaire screen
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const QuestionnaireScreen(),
          ),
        );
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Google Sign In
  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase (You would need to set up Firebase for this)
      // await FirebaseAuth.instance.signInWithCredential(credential);

      // For demo purposes, we'll just simulate the login
      await Future.delayed(const Duration(seconds: 1));

      // Extract and save the first name
      String fullName = googleUser.displayName ?? '';
      String firstName = fullName.isNotEmpty ? fullName.split(' ')[0] : 'User';

      // Save login state and user data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userName', fullName); // Store full name
      await prefs.setString('userFirstName', firstName); // Store first name separately
      await prefs.setString('userEmail', googleUser.email);
      await prefs.setString('userPhoto', googleUser.photoUrl ?? '');

      // Navigate to home screen
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const QuestionnaireScreen(),
          ),
        );
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign in failed: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: screenSize.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: screenSize.height - MediaQuery.of(context).padding.top,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        // Banner - Responsive
                        Container(
                          width: double.infinity,
                          height: screenSize.height * 0.22, // Responsive height
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200],
                            image: const DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1547592180-85f173990554?ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withAlpha(179),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome to MealMate",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenSize.width * 0.055, // Responsive font size
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Your journey to better eating starts here",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenSize.width * 0.035, // Responsive font size
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Tab Bar
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xFF4CAF50),
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey[700],
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            tabs: const [
                              Tab(text: "Login"),
                              Tab(text: "Register"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Tab Views
                        SizedBox(
                          height: screenSize.height * 0.5, // Responsive height
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // Login Form
                              SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: _emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          hintText: "Email Address",
                                          prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF4CAF50)),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your email';
                                          }
                                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                            return 'Please enter a valid email';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: _passwordController,
                                        obscureText: _obscureText,
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF4CAF50)),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscureText ? Icons.visibility_off : Icons.visibility,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          if (value.length < 6) {
                                            return 'Password must be at least 6 characters';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () {
                                            // Forgot password functionality
                                          },
                                          child: const Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                              color: Color(0xFF4CAF50),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: _isLoading ? null : _login,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF4CAF50),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: _isLoading
                                              ? const CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          )
                                              : const Text("Login"),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Divider(
                                              color: Colors.grey[300],
                                              thickness: 1,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: Text(
                                              "Or login with",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              color: Colors.grey[300],
                                              thickness: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          _socialButton(
                                            icon: FontAwesomeIcons.google,
                                            color: Colors.red,
                                            onTap: _signInWithGoogle,
                                          ),
                                          const SizedBox(width: 20),
                                          _socialButton(
                                            icon: FontAwesomeIcons.facebookF,
                                            color: Colors.blue,
                                            onTap: () {
                                              // Facebook login
                                            },
                                          ),
                                          const SizedBox(width: 20),
                                          _socialButton(
                                            icon: FontAwesomeIcons.apple,
                                            color: Colors.black,
                                            onTap: () {
                                              // Apple login
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                              // Register Form
                              SingleChildScrollView(
                                child: Form(
                                  key: _registerFormKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          hintText: "Full Name",
                                          prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF4CAF50)),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: _emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          hintText: "Email Address",
                                          prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF4CAF50)),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your email';
                                          }
                                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                            return 'Please enter a valid email';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: _passwordController,
                                        obscureText: _obscureText,
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF4CAF50)),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscureText ? Icons.visibility_off : Icons.visibility,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          if (value.length < 6) {
                                            return 'Password must be at least 6 characters';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 24),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: _isLoading ? null : _register,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF4CAF50),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: _isLoading
                                              ? const CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          )
                                              : const Text("Create Account"),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      // Add divider and "Or sign up with" text
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Divider(
                                              color: Colors.grey[300],
                                              thickness: 1,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: Text(
                                              "Or sign up with",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              color: Colors.grey[300],
                                              thickness: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      // Social media buttons
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          _socialButton(
                                            icon: FontAwesomeIcons.google,
                                            color: Colors.red,
                                            onTap: _signInWithGoogle,
                                          ),
                                          const SizedBox(width: 20),
                                          _socialButton(
                                            icon: FontAwesomeIcons.facebookF,
                                            color: Colors.blue,
                                            onTap: () {
                                              // Facebook login
                                            },
                                          ),
                                          const SizedBox(width: 20),
                                          _socialButton(
                                            icon: FontAwesomeIcons.apple,
                                            color: Colors.black,
                                            onTap: () {
                                              // Apple login
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "By signing up, you agree to our ",
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // Show terms & conditions
                                            },
                                            child: const Text(
                                              "Terms & Conditions",
                                              style: TextStyle(
                                                color: Color(0xFF4CAF50),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Loading overlay
              if (_isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(26),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }
}