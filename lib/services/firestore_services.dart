import 'package:my_mart/consts/firebase_const.dart';

class FireStoreServices {
  //get users data
  static getUserData(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
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
