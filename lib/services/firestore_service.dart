import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/items.dart';

// Service class handling all Firestore operations
class FirestoreService {
  final CollectionReference _itemsCollection =
  FirebaseFirestore.instance.collection('items');

  // Add new item
  Future<void> addItem(Item item) async {
    await _itemsCollection.add(item.toMap());
  }

  // Stream for real-time updates
  Stream<List<Item>> streamItems() {
    return _itemsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Item.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Update existing item
  Future<void> updateItem(Item item) async {
    await _itemsCollection.doc(item.id).update(item.toMap());
  }

  // Delete item
  Future<void> deleteItem(String id) async {
    await _itemsCollection.doc(id).delete();
  }
}