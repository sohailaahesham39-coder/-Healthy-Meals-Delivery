import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'New Recipe Added',
      'message': 'Check out our new Mediterranean recipes collection!',
      'time': '2h ago',
      'isRead': false,
    },
    {
      'id': '2',
      'title': 'Weekly Meal Plan Ready',
      'message': 'Your personalized meal plan for this week is ready.',
      'time': '5h ago',
      'isRead': false,
    },
    {
      'id': '3',
      'title': 'Discount Offer',
      'message': 'Use code HEALTHY20 for 20% off on your next order.',
      'time': '1d ago',
      'isRead': true,
    },
    {
      'id': '4',
      'title': 'Your Order Has Arrived',
      'message': 'Your order #1234 has been delivered. Enjoy your meal!',
      'time': '2d ago',
      'isRead': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _markAllAsRead();
  }

  Future<void> _markAllAsRead() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasUnreadNotifications', false);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () {
              setState(() {
                for (var notification in _notifications) {
                  notification['isRead'] = true;
                }
              });
              _markAllAsRead();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All notifications marked as read')),
              );
            },
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyNotifications(screenSize)
          : _buildNotificationsList(screenSize),
    );
  }

  Widget _buildEmptyNotifications(Size screenSize) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notifications_none,
            size: screenSize.width * 0.2,
            color: Colors.grey,
          ),
          SizedBox(height: screenSize.height * 0.02),
          Text(
            "No notifications yet",
            style: TextStyle(
              fontSize: screenSize.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Text(
            "We'll notify you when there's something new",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenSize.width * 0.035,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(Size screenSize) {
    return ListView.builder(
      itemCount: _notifications.length,
      padding: EdgeInsets.all(screenSize.width * 0.04),
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        return Dismissible(
          key: Key(notification['id']),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: screenSize.width * 0.05),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: screenSize.width * 0.06,
            ),
          ),
          onDismissed: (direction) {
            setState(() {
              _notifications.removeAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Notification removed')),
            );
          },
          child: GestureDetector(
            onTap: () {
              setState(() {
                notification['isRead'] = true;
              });
            },
            child: Container(
              margin: EdgeInsets.only(bottom: screenSize.height * 0.02),
              padding: EdgeInsets.all(screenSize.width * 0.04),
              decoration: BoxDecoration(
                color: notification['isRead'] ? Colors.white : const Color(0xFFF1F8E9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenSize.width * 0.12,
                    height: screenSize.width * 0.12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: const Color(0xFF4CAF50),
                      size: screenSize.width * 0.06,
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                notification['title'],
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.04,
                                  fontWeight: notification['isRead'] ? FontWeight.w500 : FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (!notification['isRead'])
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4CAF50),
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.008),
                        Text(
                          notification['message'],
                          style: TextStyle(
                            fontSize: screenSize.width * 0.035,
                            color: Colors.grey[700],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        Text(
                          notification['time'],
                          style: TextStyle(
                            fontSize: screenSize.width * 0.03,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}