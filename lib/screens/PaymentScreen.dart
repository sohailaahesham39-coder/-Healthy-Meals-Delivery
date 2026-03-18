import 'package:flutter/material.dart';
import 'OrderTrackingScreen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0;
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'Credit Card',
      'icon': Icons.credit_card,
      'color': Colors.blue,
      'last4': '4242',
    },
    {
      'name': 'PayPal',
      'icon': Icons.account_balance_wallet,
      'color': Colors.indigo,
    },
    {
      'name': 'Apple Pay',
      'icon': Icons.apple,
      'color': Colors.black,
    },
    {
      'name': 'Cash on Delivery',
      'icon': Icons.money,
      'color': Colors.green,
    },
  ];

  final TextEditingController _instructionsController = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenSize.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: screenSize.width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
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
                              "\$35.97",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.01),
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
                              "\$3.99",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tax",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              "\$2.88",
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
                              "\$42.84",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.045,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4CAF50),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenSize.height * 0.03),

                  // Payment Methods
                  Text(
                    "Payment Method",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _paymentMethods.length,
                    itemBuilder: (context, index) {
                      final method = _paymentMethods[index];
                      final isSelected = _selectedPaymentMethod == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPaymentMethod = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: screenSize.height * 0.015),
                          padding: EdgeInsets.all(screenSize.width * 0.04),
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                              Container(
                                padding: EdgeInsets.all(screenSize.width * 0.02),
                                decoration: BoxDecoration(
                                  color: method['color'].withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  method['icon'],
                                  color: method['color'],
                                  size: screenSize.width * 0.06,
                                ),
                              ),
                              SizedBox(width: screenSize.width * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    method['name'],
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.04,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (method.containsKey('last4'))
                                    Text(
                                      "•••• ${method['last4']}",
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.035,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                ],
                              ),
                              const Spacer(),
                              Icon(
                                isSelected
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: isSelected
                                    ? const Color(0xFF4CAF50)
                                    : Colors.grey,
                                size: screenSize.width * 0.06,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: screenSize.height * 0.02),

                  OutlinedButton.icon(
                    onPressed: () {
                      // Add new payment method
                      _showAddPaymentMethodDialog(context, screenSize);
                    },
                    icon: Icon(
                      Icons.add,
                      size: screenSize.width * 0.04,
                    ),
                    label: Text(
                      "Add Payment Method",
                      style: TextStyle(
                        fontSize: screenSize.width * 0.035,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF4CAF50),
                      side: const BorderSide(color: Color(0xFF4CAF50)),
                      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.015),
                      minimumSize: const Size(double.infinity, 0),
                    ),
                  ),

                  SizedBox(height: screenSize.height * 0.03),

                  // Delivery Time
                  Text(
                    "Delivery Time",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),

                  Container(
                    padding: EdgeInsets.all(screenSize.width * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(screenSize.width * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.access_time,
                            color: Colors.blue,
                            size: screenSize.width * 0.06,
                          ),
                        ),
                        SizedBox(width: screenSize.width * 0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Standard Delivery",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "30-45 minutes",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            // Change delivery option
                            _showDeliveryOptionsDialog(context, screenSize);
                          },
                          child: Text(
                            "Change",
                            style: TextStyle(
                              fontSize: screenSize.width * 0.035,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenSize.height * 0.03),

                  // Special Instructions
                  Text(
                    "Special Instructions",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),

                  TextField(
                    controller: _instructionsController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Add any special instructions here...",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),

                  // Space for bottom button
                  SizedBox(height: screenSize.height * 0.1),
                ],
              ),
            ),
          ),
          // Loading overlay
          if (_isProcessing)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
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
        child: SafeArea(
          child: ElevatedButton(
            onPressed: _isProcessing ? null : () {
              // Process payment and navigate to order tracking
              _processPayment(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
            ),
            child: _isProcessing
                ? SizedBox(
              height: screenSize.width * 0.05,
              width: screenSize.width * 0.05,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            )
                : Text(
              "Place Order",
              style: TextStyle(
                fontSize: screenSize.width * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _processPayment(BuildContext context) async {
    setState(() {
      _isProcessing = true;
    });

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isProcessing = false;
    });

    // Navigate to order tracking screen
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OrderTrackingScreen(),
        ),
      );
    }
  }

  void _showAddPaymentMethodDialog(BuildContext context, Size screenSize) {
    final TextEditingController _cardNumberController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _expiryController = TextEditingController();
    final TextEditingController _cvvController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Payment Method",
                style: TextStyle(
                  fontSize: screenSize.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              TextField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Card Number",
                  hintText: "XXXX XXXX XXXX XXXX",
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Cardholder Name",
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _expiryController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: "Expiry Date",
                        hintText: "MM/YY",
                      ),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.04),
                  Expanded(
                    child: TextField(
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "CVV",
                        hintText: "XXX",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.03),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('New payment method added'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
                  ),
                  child: const Text("Save Card"),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
            ],
          ),
        );
      },
    );
  }

  void _showDeliveryOptionsDialog(BuildContext context, Size screenSize) {
    int _selectedOption = 0;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Delivery Options'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDeliveryOption(
                  title: 'Standard Delivery',
                  subtitle: '30-45 minutes',
                  fee: '\$3.99',
                  index: 0,
                  selectedIndex: _selectedOption,
                  onTap: () {
                    setState(() {
                      _selectedOption = 0;
                    });
                  },
                  screenSize: screenSize,
                ),
                SizedBox(height: screenSize.height * 0.01),
                _buildDeliveryOption(
                  title: 'Express Delivery',
                  subtitle: '15-25 minutes',
                  fee: '\$5.99',
                  index: 1,
                  selectedIndex: _selectedOption,
                  onTap: () {
                    setState(() {
                      _selectedOption = 1;
                    });
                  },
                  screenSize: screenSize,
                ),
                SizedBox(height: screenSize.height * 0.01),
                _buildDeliveryOption(
                  title: 'Scheduled Delivery',
                  subtitle: 'Choose a time',
                  fee: '\$3.99',
                  index: 2,
                  selectedIndex: _selectedOption,
                  onTap: () {
                    setState(() {
                      _selectedOption = 2;
                    });
                  },
                  screenSize: screenSize,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Confirm'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDeliveryOption({
    required String title,
    required String subtitle,
    required String fee,
    required int index,
    required int selectedIndex,
    required VoidCallback onTap,
    required Size screenSize,
  }) {
    final bool isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(screenSize.width * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenSize.width * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: screenSize.width * 0.03,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              fee,
              style: TextStyle(
                fontSize: screenSize.width * 0.035,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4CAF50),
              ),
            ),
            SizedBox(width: screenSize.width * 0.02),
            Icon(
              isSelected
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: isSelected
                  ? const Color(0xFF4CAF50)
                  : Colors.grey,
              size: screenSize.width * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}