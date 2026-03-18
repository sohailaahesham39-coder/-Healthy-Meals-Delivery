import 'package:flutter/material.dart';
import 'OrderTrackingScreen.dart';
import 'home.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _activeOrders = [
    {
      'id': '12345',
      'date': 'March 24, 2025',
      'time': '12:05 PM',
      'status': 'On the way',
      'items': 3,
      'total': 42.84,
    },
  ];

  final List<Map<String, dynamic>> _pastOrders = [
    {
      'id': '12344',
      'date': 'March 18, 2025',
      'time': '1:30 PM',
      'status': 'Delivered',
      'items': 2,
      'total': 28.50,
    },
    {
      'id': '12343',
      'date': 'March 15, 2025',
      'time': '7:45 PM',
      'status': 'Delivered',
      'items': 4,
      'total': 56.20,
    },
    {
      'id': '12342',
      'date': 'March 10, 2025',
      'time': '1:15 PM',
      'status': 'Delivered',
      'items': 1,
      'total': 14.99,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF4CAF50),
          labelColor: const Color(0xFF4CAF50),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Past Orders'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active Orders
          _activeOrders.isEmpty
              ? _buildEmptyOrders('No active orders', screenSize)
              : _buildOrdersList(_activeOrders, screenSize, true),

          // Past Orders
          _pastOrders.isEmpty
              ? _buildEmptyOrders('No past orders', screenSize)
              : _buildOrdersList(_pastOrders, screenSize, false),
        ],
      ),
    );
  }

  Widget _buildEmptyOrders(String message, Size screenSize) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: screenSize.width * 0.2,
            color: Colors.grey,
          ),
          SizedBox(height: screenSize.height * 0.02),
          Text(
            message,
            style: TextStyle(
              fontSize: screenSize.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Text(
            'Your orders will appear here',
            style: TextStyle(
              fontSize: screenSize.width * 0.035,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: screenSize.height * 0.03),
          ElevatedButton(
            onPressed: () {
              // Navigate to home to make an order
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.06,
                  vertical: screenSize.height * 0.015
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Browse Meals",
              style: TextStyle(
                fontSize: screenSize.width * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Map<String, dynamic>> orders, Size screenSize, bool isActive) {
    return ListView.builder(
      padding: EdgeInsets.all(screenSize.width * 0.04),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final bool isActiveOrder = order['status'] != 'Delivered';

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderTrackingScreen(),
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
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(screenSize.width * 0.04),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order #${order['id']}',
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: screenSize.height * 0.005),
                                Text(
                                  '${order['date']} | ${order['time']}',
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.035,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.03,
                              vertical: screenSize.height * 0.006,
                            ),
                            decoration: BoxDecoration(
                              color: isActiveOrder
                                  ? const Color(0xFF4CAF50).withOpacity(0.1)
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              order['status'],
                              style: TextStyle(
                                fontSize: screenSize.width * 0.03,
                                fontWeight: FontWeight.w600,
                                color: isActiveOrder
                                    ? const Color(0xFF4CAF50)
                                    : Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: screenSize.width * 0.04,
                                color: Colors.grey,
                              ),
                              SizedBox(width: screenSize.width * 0.01),
                              Text(
                                '${order['items']} items',
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.035,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '\$${order['total'].toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: screenSize.width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF4CAF50),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isActiveOrder)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.015),
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Track Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.width * 0.035,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}