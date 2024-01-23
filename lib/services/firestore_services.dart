import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_mart/consts/firebase_const.dart';

class FireStoreServices {
  //get users data
  static Future<DocumentSnapshot?> getUserData(uid) async {
    try {
      var snapshot = await firestore
          .collection(usersCollection)
          .doc(
              uid) // Assuming 'id' is the document ID, use .doc(uid) instead of .where('id', isEqualTo: uid)
          .get();
      return snapshot;
    } catch (e) {
      // Handle any errors here
      print("Error fetching user data: $e");
      return null;
    }
  }

  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  static getCart(uid) {
    return firestore
        .collection(cartCllection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deleteDoc(docId) {
    return firestore.collection(cartCllection).doc(docId).delete();
  }
}
