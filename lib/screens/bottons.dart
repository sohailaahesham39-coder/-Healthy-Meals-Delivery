// import 'package:flutter/material.dart';
//
// import 'Login Screen Implementation.dart';
// import '../main.dart';
// import 'home.dart';
//
//
//
//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   bool _notificationsEnabled = true;
//   bool _darkModeEnabled = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Profile section
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 70,
//                       height: 70,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(35),
//                         color: Colors.grey[200],
//                         image: const DecorationImage(
//                           image: NetworkImage(
//                             'https://randomuser.me/api/portraits/men/32.jpg',
//                           ),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'John Doe',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'john.doe@example.com',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(
//                         Icons.edit_outlined,
//                         color: Color(0xFF4CAF50),
//                       ),
//                       onPressed: () {
//                         // Edit profile
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // Account settings
//               const Text(
//                 'Account',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               _buildSettingsItem(
//                 icon: Icons.person_outline,
//                 title: 'Personal Information',
//                 onTap: () {
//                   // Navigate to personal information screen
//                 },
//               ),
//               _buildSettingsItem(
//                 icon: Icons.location_on_outlined,
//                 title: 'Saved Addresses',
//                 onTap: () {
//                   // Navigate to saved addresses screen
//                 },
//               ),
//               _buildSettingsItem(
//                 icon: Icons.payment_outlined,
//                 title: 'Payment Methods',
//                 onTap: () {
//                   // Navigate to payment methods screen
//                 },
//               ),
//               _buildSettingsItem(
//                 icon: Icons.history_outlined,
//                 title: 'Order History',
//                 onTap: () {
//                   // Navigate to order history screen
//                 },
//               ),
//
//               const SizedBox(height: 24),
//
//               // Preferences
//               const Text(
//                 'Preferences',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.blue.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: const Icon(
//                             Icons.notifications_outlined,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Notifications',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 'Get updates on new offers and orders',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.grey[700],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Switch(
//                           value: _notificationsEnabled,
//                           onChanged: (value) {
//                             setState(() {
//                               _notificationsEnabled = value;
//                             });
//                           },
//                           activeColor: const Color(0xFF4CAF50),
//                         ),
//                       ],
//                     ),
//                     const Divider(height: 32),
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.purple.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: const Icon(
//                             Icons.dark_mode_outlined,
//                             color: Colors.purple,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Dark Mode',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 'Change app appearance',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.grey[700],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Switch(
//                           value: _darkModeEnabled,
//                           onChanged: (value) {
//                             setState(() {
//                               _darkModeEnabled = value;
//                             });
//                           },
//                           activeColor: const Color(0xFF4CAF50),
//                         ),
//                       ],
//                     ),
//                     const Divider(height: 32),
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.orange.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: const Icon(
//                             Icons.language_outlined,
//                             color: Colors.orange,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Language',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 'English (US)',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.grey[700],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(
//                             Icons.arrow_forward_ios,
//                             size: 16,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             // Open language selection
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // About
//               const Text(
//                 'About',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               _buildSettingsItem(
//                 icon: Icons.info_outline,
//                 title: 'About MealMate',
//                 onTap: () {
//                   // Show app info
//                 },
//               ),
//               _buildSettingsItem(
//                 icon: Icons.privacy_tip_outlined,
//                 title: 'Privacy Policy',
//                 onTap: () {
//                   // Show privacy policy
//                 },
//               ),
//               _buildSettingsItem(
//                 icon: Icons.description_outlined,
//                 title: 'Terms of Service',
//                 onTap: () {
//                   // Show terms of service
//                 },
//               ),
//               _buildSettingsItem(
//                 icon: Icons.help_outline,
//                 title: 'Help & Support',
//                 onTap: () {
//                   // Navigate to help & support
//                 },
//               ),
//
//               const SizedBox(height: 24),
//
//               // Logout button
//               SizedBox(
//                 width: double.infinity,
//                 child: OutlinedButton.icon(
//                   onPressed: () {
//                     // Show logout confirmation dialog
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Logout'),
//                         content: const Text('Are you sure you want to logout?'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: const Text('Cancel'),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                               // Navigate to login screen
//                               Navigator.of(context).pushAndRemoveUntil(
//                                 MaterialPageRoute(
//                                   builder: (context) => const LoginScreen(),
//                                 ),
//                                     (route) => false,
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red,
//                             ),
//                             child: const Text('Logout'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   icon: const Icon(Icons.logout, color: Colors.red),
//                   label: const Text(
//                     'Logout',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     side: const BorderSide(color: Colors.red),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 8),
//
//               Center(
//                 child: Text(
//                   'Version 1.0.0',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSettingsItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: const Color(0xFF4CAF50).withOpacity(0.1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(
//             icon,
//             color: const Color(0xFF4CAF50),
//           ),
//         ),
//         title: Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         trailing: const Icon(
//           Icons.arrow_forward_ios,
//           size: 16,
//           color: Colors.grey,
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
// }