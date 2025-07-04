import 'package:flutter/material.dart';
import 'order_confirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final double totalAmount;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.totalAmount,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _street = '';
  String _city = '';
  String _postalCode = '';
  String _phone = '';
  String _deliveryOption = 'Standard Delivery';

  @override
  Widget build(BuildContext context) {
    final deliveryFee = _deliveryOption == 'Standard Delivery' ? 100.0 : 150.0;
    final totalWithDelivery = widget.totalAmount + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: const Text('Checkout', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCard('Delivery Information', Icons.location_on, Colors.red[600]!, [
                _buildField('Full Name', Icons.person_outline, validator: (v) => v?.isEmpty == true ? 'Please enter your name' : null, onSaved: (v) => _name = v ?? ''),
                _buildField('Street', Icons.home_outlined, validator: (v) => v?.isEmpty == true ? 'Please enter your street' : null, onSaved: (v) => _street = v ?? ''),
                _buildField('City', Icons.location_on, validator: (v) => v?.isEmpty == true ? 'Please enter your city' : null, onSaved: (v) => _city = v ?? ''),
                _buildField('Postal Code', Icons.pin_drop, validator: (v) => v?.isEmpty == true ? 'Please enter your postal code' : null, onSaved: (v) => _postalCode = v ?? ''),
                _buildField('Phone Number', Icons.phone_outlined, keyboardType: TextInputType.phone, validator: (v) => v?.isEmpty == true ? 'Please enter your phone number' : null, onSaved: (v) => _phone = v ?? ''),
              ]),
              const SizedBox(height: 20),
              _buildCard('Delivery Option', Icons.local_shipping_outlined, Colors.blue[600]!, [
                _buildRadio('Standard Delivery', '₱100', '3-5 business days', Colors.green, 'Standard Delivery'),
                _buildRadio('Express Delivery', '₱150', '1-2 business days', Colors.orange, 'Express Delivery'),
              ]),
              const SizedBox(height: 20),
              _buildCard('Payment Method', Icons.payment_outlined, Colors.green[600]!, [
                _buildPayment('Cash on Delivery', 'Default', 'Pay when you receive your order'),
              ]),
              const SizedBox(height: 20),
              _buildCard('Order Summary', Icons.receipt_long, Colors.orange[600]!, [
                _buildOrderSummary(deliveryFee, totalWithDelivery),
              ]),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total: ₱${totalWithDelivery.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[600],
                    ),
                  ),
                  Text(
                    'Including delivery fee',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _placeOrder(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, Color iconColor, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, IconData prefixIcon, {int? maxLines, TextInputType? keyboardType, String? Function(String?)? validator, void Function(String?)? onSaved}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefixIcon, color: Colors.grey[600]),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[300]!)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[300]!)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.red[600]!, width: 2)),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }

  Widget _buildRadio(String title, String price, String duration, Color color, String value) {
    final isSelected = _deliveryOption == value;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? color : Colors.grey[300]!, width: isSelected ? 2 : 1),
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? color.withOpacity(0.05) : Colors.transparent,
      ),
      child: RadioListTile<String>(
        title: Row(children: [
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: Text(price, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ]),
        subtitle: Text(duration, style: TextStyle(color: Colors.grey[600])),
        value: value,
        groupValue: _deliveryOption,
        activeColor: color,
        onChanged: (val) => setState(() => _deliveryOption = val!),
      ),
    );
  }

  Widget _buildPayment(String title, String badge, String description) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green[300]!, width: 2),
        borderRadius: BorderRadius.circular(8),
        color: Colors.green[50],
      ),
      child: RadioListTile<String>(
        title: Row(children: [
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.green[200], borderRadius: BorderRadius.circular(12)),
            child: Text(badge, style: TextStyle(color: Colors.green[700], fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ]),
        subtitle: Text(description, style: TextStyle(color: Colors.grey[600])),
        value: 'Cash on Delivery',
        groupValue: 'Cash on Delivery',
        activeColor: Colors.green[600],
        onChanged: null,
        selected: true,
      ),
    );
  }

  Widget _buildOrderSummary(double deliveryFee, double totalWithDelivery) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          // Order items
          ...widget.cartItems.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item['image']!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Qty: [200~[200~${item['qty']}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '₱${(double.tryParse(item['price'].toString().replaceAll('₱', '')) ?? 0.0) * (item['qty'] ?? 1)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )).toList(),
          const Divider(height: 24),
          _buildSummaryRow('Subtotal', '₱${widget.totalAmount.toStringAsFixed(2)}'),
          _buildSummaryRow('Delivery Fee', '₱${deliveryFee.toStringAsFixed(2)}'),
          const Divider(height: 16),
          _buildSummaryRow('Total', '₱${totalWithDelivery.toStringAsFixed(2)}', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal ? Colors.black : Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? Colors.red[600] : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _placeOrder(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Debug print to see what values are being passed
      print('CheckoutScreen - Name: $_name');
      print('CheckoutScreen - Street: $_street');
      print('CheckoutScreen - City: $_city');
      print('CheckoutScreen - Postal Code: $_postalCode');
      print('CheckoutScreen - Delivery Option: $_deliveryOption');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OrderConfirmationScreen(
            name: _name,
            street: _street,
            city: _city,
            postalCode: _postalCode,
            deliveryOption: _deliveryOption,
          ),
        ),
      );
    }
  }
} 