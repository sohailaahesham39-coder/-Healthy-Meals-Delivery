import 'package:flutter/material.dart';
import 'PaymentScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'name': 'Mediterranean Quinoa Bowl',
      'image': 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
      'price': 12.99,
      'quantity': 1,
    },
    {
      'id': '2',
      'name': 'Avocado Toast with Poached Eggs',
      'image': 'https://images.unsplash.com/photo-1525351484163-7529414344d8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80',
      'price': 9.99,
      'quantity': 2,
    },
  ];

  double get _subtotal {
    return _cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  double get _deliveryFee => 3.99;
  double get _tax => _subtotal * 0.08;
  double get _total => _subtotal + _deliveryFee + _tax;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyCart(screenSize)
          : _buildCartItems(screenSize),
      bottomNavigationBar: _cartItems.isEmpty
          ? null
          : _buildCheckoutSection(screenSize),
    );
  }

  Widget _buildEmptyCart(Size screenSize) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: screenSize.width * 0.2,
            color: Colors.grey,
          ),
          SizedBox(height: screenSize.height * 0.02),
          Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: screenSize.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Text(
            "Looks like you haven't added any meals to your cart yet.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenSize.width * 0.035,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: screenSize.height * 0.03),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Navigate back to home screen
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

  Widget _buildCartItems(Size screenSize) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Items (${_cartItems.length})",
              style: TextStyle(
                fontSize: screenSize.width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return Container(
                  margin: EdgeInsets.only(bottom: screenSize.height * 0.015),
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
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                        child: Image.network(
                          item['image'],
                          width: screenSize.width * 0.25,
                          height: screenSize.width * 0.25,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: screenSize.width * 0.25,
                              height: screenSize.width * 0.25,
                              color: Colors.grey[200],
                              child: const Icon(Icons.image_not_supported, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(screenSize.width * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: screenSize.height * 0.01),
                              Text(
                                "\$${(item['price'] * item['quantity']).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4CAF50),
                                ),
                              ),
                              SizedBox(height: screenSize.height * 0.01),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {
                                            setState(() {
                                              if (item['quantity'] > 1) {
                                                item['quantity']--;
                                              } else {
                                                _cartItems.removeAt(index);
                                              }
                                            });
                                          },
                                          iconSize: screenSize.width * 0.045,
                                          padding: EdgeInsets.all(screenSize.width * 0.01),
                                          constraints: const BoxConstraints(),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
                                          child: Text(
                                            "${item['quantity']}",
                                            style: TextStyle(
                                              fontSize: screenSize.width * 0.035,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              item['quantity']++;
                                            });
                                          },
                                          iconSize: screenSize.width * 0.045,
                                          padding: EdgeInsets.all(screenSize.width * 0.01),
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _cartItems.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: screenSize.height * 0.03),
            Container(
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        "\$${_subtotal.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Fee",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        "\$${_deliveryFee.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tax (8%)",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        "\$${_tax.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.015),
                    child: const Divider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${_total.toStringAsFixed(2)}",
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
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutSection(Size screenSize) {
    return Container(
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
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PaymentScreen(),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Proceed to Checkout",
              style: TextStyle(
                fontSize: screenSize.width * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "\$${_total.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: screenSize.width * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}