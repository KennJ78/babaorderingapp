class Order {
  final String id;
  final String orderReference;
  final String customerName;
  final String street;
  final String city;
  final String postalCode;
  final String phone;
  final String deliveryOption;
  final double totalAmount;
  final double deliveryFee;
  final List<Map<String, dynamic>> items;
  final DateTime orderDate;
  final String status;

  Order({
    required this.id,
    required this.orderReference,
    required this.customerName,
    required this.street,
    required this.city,
    required this.postalCode,
    required this.phone,
    required this.deliveryOption,
    required this.totalAmount,
    required this.deliveryFee,
    required this.items,
    required this.orderDate,
    this.status = 'Pending',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderReference': orderReference,
      'customerName': customerName,
      'street': street,
      'city': city,
      'postalCode': postalCode,
      'phone': phone,
      'deliveryOption': deliveryOption,
      'totalAmount': totalAmount,
      'deliveryFee': deliveryFee,
      'items': items,
      'orderDate': orderDate.toIso8601String(),
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      orderReference: map['orderReference'],
      customerName: map['customerName'],
      street: map['street'],
      city: map['city'],
      postalCode: map['postalCode'],
      phone: map['phone'],
      deliveryOption: map['deliveryOption'],
      totalAmount: map['totalAmount'].toDouble(),
      deliveryFee: map['deliveryFee'].toDouble(),
      items: List<Map<String, dynamic>>.from(map['items']),
      orderDate: DateTime.parse(map['orderDate']),
      status: map['status'],
    );
  }
} 