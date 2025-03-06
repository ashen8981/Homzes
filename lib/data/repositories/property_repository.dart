import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/property_model.dart';

class PropertyRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PropertyModel>> fetchProperties() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('properties').get();
      return snapshot.docs.map((doc) => PropertyModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception("Failed to fetch properties: $e");
    }
  }
}
