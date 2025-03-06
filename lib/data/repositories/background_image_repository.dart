import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/background_image_model.dart';

class BackgroundImageRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<BackgroundImageModel> fetchBackgroundImage() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('bacgroundImg').doc('bgIMG').get();
      if (doc.exists) {
        return BackgroundImageModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        throw Exception("Document does not exist");
      }
    } catch (e) {
      throw Exception("Failed to fetch background image: $e");
    }
  }
}
