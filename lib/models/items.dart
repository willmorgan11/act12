import 'package:cloud_firestore/cloud_firestore.dart';

// Model for inventory items with defined data types
class Item {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String category;
  final DateTime createdAt;

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.category,
    required this.createdAt,
  });

  // Convert Item object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'category': category,
      'createdAt': Timestamp.fromDate(createdAt), // Convert DateTime to Timestamp
    };
  }

  // Create Item from Firestore document
  factory Item.fromMap(String id, Map<String, dynamic> map) {
    // Handle Timestamp conversion safely
    DateTime createdAt;
    if (map['createdAt'] is Timestamp) {
      createdAt = (map['createdAt'] as Timestamp).toDate();
    } else if (map['createdAt'] is DateTime) {
      createdAt = map['createdAt'] as DateTime;
    } else {
      createdAt = DateTime.now();
    }

    return Item(
      id: id,
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      quantity: map['quantity'] ?? 0,
      category: map['category'] ?? 'Uncategorized',
      createdAt: createdAt,
    );
  }

  // Copy with method for updates
  Item copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
    String? category,
    DateTime? createdAt,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}