import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String name;
  final String street;
  final String city;
  final String postalCode;
  final String deliveryOption;

  const OrderConfirmationScreen({
    super.key,
    required this.name,
    required this.street,
    required this.city,
    required this.postalCode,
    required this.deliveryOption,
  });

  @override
  Widget build(BuildContext context) {

    final displayName = name.isEmpty ? 'Customer' : name;
    final displayStreet = street.isEmpty ? '123 Main Street' : street;
    final displayCity = city.isEmpty ? 'City' : city;
    final displayPostalCode = postalCode.isEmpty ? '12345' : postalCode;
    final displayDeliveryOption = deliveryOption.isEmpty ? 'Standard Delivery' : deliveryOption;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        elevation: 0,
        title: const Text(
          'Order Confirmation',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.red[600]!,
                    Colors.red[500]!,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // Success Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      size: 50,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Order Placed Successfully!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Thank you for your order, $displayName!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Delivery Information Card
                  _buildInfoCard(
                    icon: Icons.location_on,
                    title: 'Delivery Address',
                    content: '$displayStreet, $displayCity $displayPostalCode',
                    color: Colors.blue[600]!,
                  ),

                  const SizedBox(height: 16),


                  _buildInfoCard(
                    icon: Icons.local_shipping,
                    title: 'Delivery Method',
                    content: displayDeliveryOption,
                    color: Colors.orange[600]!,
                  ),

                  const SizedBox(height: 16),


                  _buildInfoCard(
                    icon: Icons.payment,
                    title: 'Payment Method',
                    content: 'Cash on Delivery',
                    color: Colors.green[600]!,
                  ),

                  const SizedBox(height: 30),

                  // Continue Shopping Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to home screen and clear the navigation stack
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/home',
                          (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[600],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        shadowColor: Colors.red.withOpacity(0.3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Continue Shopping',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 