import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/consts/firebase_const.dart';

class FireStoreServices {
  //get users data
  // static Future<DocumentSnapshot?> getUserData(uid) async {
  //   try {
  //     var snapshot = await firestore
  //         .collection(usersCollection)
  //         .doc(
  //             uid) // Assuming 'id' is the document ID, use .doc(uid) instead of .where('id', isEqualTo: uid)
  //         .get();
  //     return snapshot;
  //   } catch (e) {
  //     // Handle any errors here
  //     print("Error fetching user data: $e");
  //     return null;
  //   }
  // }
  static getUserData(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .get();
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

  static getChatmsg(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection(orderCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getAllWishList() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  // static getCounts() async {
  //   var res = Future.wait({
  //     firestore
  //         .collection(cartCllection)
  //         .where('added_by', isEqualTo: currentUser!.uid)
  //         .get()
  //         .then((value) {
  //       return value.docs.length;
  //     }),
  //     firestore
  //         .collection(productsCollection)
  //         .where('p_wishlist', arrayContains: currentUser!.uid)
  //         .get()
  //         .then((value) {
  //       return value.docs.length;
  //     }),
  //     firestore
  //         .collection(orderCollection)
  //         .where('order_by', isEqualTo: currentUser!.uid)
  //         .get()
  //         .then((value) {
  //       return value.docs.length;
  //     })
  //   });

  //   return res;
  // }

  static Stream<List<int>> getCountsStream() async* {
    final counts = await Future.wait([
      firestore
          .collection(cartCllection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) => value.docs.length),
      firestore
          .collection(productsCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) => value.docs.length),
      firestore
          .collection(orderCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) => value.docs.length),
    ]);

    yield counts;
  }

  static getAllProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

  static getFeaturedProducts() {
    return firestore
        .collection(productsCollection)
        .where('is_featured', isEqualTo: true)
        .get();
  }
}
