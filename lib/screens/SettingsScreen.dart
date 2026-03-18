import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Login Screen Implementation.dart';

class SettingsScreen extends StatefulWidget {
  final String? userName;
  final String? userEmail;

  const SettingsScreen({
    Key? key,
    this.userName,
    this.userEmail
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  // Get user data from login screen
  late String _userName;
  late String _userEmail;

  @override
  void initState() {
    super.initState();
    _userName = widget.userName ?? 'John Doe';
    _userEmail = widget.userEmail ?? 'john.doe@example.com';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if dark mode is already enabled in the system
    _darkModeEnabled = Theme.of(context).brightness == Brightness.dark;
  }

  // Toggle theme mode
  void _toggleTheme() {
    setState(() {
      _darkModeEnabled = !_darkModeEnabled;
    });

    // Instead of recreating the MaterialApp, use a callback to update the theme
    // in the parent widget, or use a state management solution like Provider
    // For this example, we'll just update the UI of this screen
  }

  @override
  Widget build(BuildContext context) {
    // Determine colors based on theme
    final bool isDark = _darkModeEnabled;
    final Color cardColor = isDark ? Colors.grey[800]! : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black;
    final Color subtitleColor = isDark ? Colors.grey[400]! : Colors.grey[700]!;
    final Color dividerColor = isDark ? Colors.grey[700]! : Colors.grey[300]!;
    final Color iconBgColor = isDark ? Colors.grey[700]! : Colors.grey[200]!;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: isDark ? Colors.grey[850] : Colors.white,
        foregroundColor: textColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
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
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: iconBgColor,
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://randomuser.me/api/portraits/men/32.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _userEmail,
                            style: TextStyle(
                              fontSize: 14,
                              color: subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Color(0xFF4CAF50),
                      ),
                      onPressed: () {
                        // Edit profile
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Account settings
              Text(
                'Account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),

              _buildSettingsItem(
                icon: Icons.person_outline,
                title: 'Personal Information',
                isDark: isDark,
                onTap: () {
                  // Navigate to personal information screen
                },
              ),
              _buildSettingsItem(
                icon: Icons.location_on_outlined,
                title: 'Saved Addresses',
                isDark: isDark,
                onTap: () {
                  // Navigate to saved addresses screen
                },
              ),
              _buildSettingsItem(
                icon: Icons.payment_outlined,
                title: 'Payment Methods',
                isDark: isDark,
                onTap: () {
                  // Navigate to payment methods screen
                },
              ),
              _buildSettingsItem(
                icon: Icons.history_outlined,
                title: 'Order History',
                isDark: isDark,
                onTap: () {
                  // Navigate to order history screen
                },
              ),

              const SizedBox(height: 24),

              // Preferences
              Text(
                'Preferences',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
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
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Notifications',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Get updates on new offers and orders',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                          activeColor: const Color(0xFF4CAF50),
                        ),
                      ],
                    ),
                    Divider(height: 32, color: dividerColor),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.dark_mode_outlined,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dark Mode',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Change app appearance',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _darkModeEnabled,
                          onChanged: (value) {
                            setState(() {
                              _darkModeEnabled = value;
                              _toggleTheme();
                            });
                          },
                          activeColor: const Color(0xFF4CAF50),
                        ),
                      ],
                    ),
                    Divider(height: 32, color: dividerColor),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.language_outlined,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Language',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'English (US)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: subtitleColor,
                          ),
                          onPressed: () {
                            // Open language selection
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // About
              Text(
                'About',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),

              _buildSettingsItem(
                icon: Icons.info_outline,
                title: 'About MealMate',
                isDark: isDark,
                onTap: () {
                  // Show app info
                },
              ),
              _buildSettingsItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                isDark: isDark,
                onTap: () {
                  // Show privacy policy
                },
              ),
              _buildSettingsItem(
                icon: Icons.description_outlined,
                title: 'Terms of Service',
                isDark: isDark,
                onTap: () {
                  // Show terms of service
                },
              ),
              _buildSettingsItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                isDark: isDark,
                onTap: () {
                  // Navigate to help & support
                },
              ),

              const SizedBox(height: 24),

              // Logout button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Show logout confirmation dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Navigate to login screen
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                    (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: subtitleColor,
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    final Color cardColor = isDark ? Colors.grey[800]! : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
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
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF4CAF50),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDark ? Colors.grey[400] : Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}