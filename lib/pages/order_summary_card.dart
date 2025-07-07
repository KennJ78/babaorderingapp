import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderSummaryCard extends StatefulWidget {
  final Order order;
  const OrderSummaryCard({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderSummaryCard> createState() => _OrderSummaryCardState();
}

class _OrderSummaryCardState extends State<OrderSummaryCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final totalAmount = order.totalAmount + order.deliveryFee;
    final firstItem = order.items.isNotEmpty ? order.items[0] : null;
    final productImage = firstItem != null && firstItem['image'] != null && firstItem['image'].toString().startsWith('http')
        ? NetworkImage(firstItem['image'])
        : const AssetImage('assets/images/logo1.png'); // Placeholder

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show all product images as thumbnails
                SizedBox(
                  width: 70,
                  child: Column(
                    children: [
                      for (var item in order.items.take(3))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 54,
                                height: 54,
                                color: Colors.grey[200],
                                child: (item['image'] != null && item['image'].toString().startsWith('http'))
                                  ? Image.network(item['image'], fit: BoxFit.cover, width: 54, height: 54)
                                  : (item['image'] != null && item['image'].toString().startsWith('assets/'))
                                    ? Image.asset(item['image'], fit: BoxFit.cover, width: 54, height: 54)
                                    : Image.asset('assets/images/logo1.png', fit: BoxFit.cover, width: 54, height: 54),
                              ),
                            ),
                          ),
                        ),
                      if (order.items.length > 3)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text('+${order.items.length - 3} more', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order #${order.orderReference}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text('${order.items.length} item${order.items.length > 1 ? 's' : ''}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                      const SizedBox(height: 4),
                      Text('₱${totalAmount.toStringAsFixed(2)}', style: TextStyle(color: Colors.red[600], fontWeight: FontWeight.w600, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text('Status: ${order.status}', style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[600],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  child: Text(_expanded ? 'Hide' : 'View'),
                ),
              ],
            ),
            if (_expanded) ...[
              const SizedBox(height: 16),
              const Divider(),
              Text('Items', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              ...order.items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 44,
                          height: 44,
                          color: Colors.grey[200],
                          child: (item['image'] != null && item['image'].toString().startsWith('http'))
                            ? Image.network(item['image'], fit: BoxFit.cover, width: 44, height: 44)
                            : (item['image'] != null && item['image'].toString().startsWith('assets/'))
                              ? Image.asset(item['image'], fit: BoxFit.cover, width: 44, height: 44)
                              : Image.asset('assets/images/logo1.png', fit: BoxFit.cover, width: 44, height: 44),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(item['name'], style: const TextStyle(fontSize: 15))),
                    Text('x${item['quantity'] ?? item['qty']}', style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(width: 12),
                    Text('₱${item['price']}', style: const TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
              )),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Delivery Fee', style: TextStyle(fontSize: 15)),
                  Text('₱${order.deliveryFee.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  Text(
                    '₱${(order.totalAmount + order.deliveryFee).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              Text('Delivery Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Text('Name: ${order.customerName}'),
              Text('Phone: ${order.phone}'),
              Text('Address: ${order.street}, ${order.city}, ${order.postalCode}'),
              Text('Delivery Option: ${order.deliveryOption}'),
              // Payment method placeholder (add if available in model)
              // Text('Payment Method: ${order.paymentMethod}'),
            ],
          ],
        ),
      ),
    );
  }
} 