import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/consts/firebase_const.dart';
import 'package:my_mart/models/category_model.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var subcat = [];

  var isFav = false.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var decode = categoyModelFromJson(data);
    var s =
        decode.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuantity(totalQuanitity) {
    if (quantity.value < totalQuanitity) {
      quantity.value++;
    }
  }

  decreQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart(
      {title, img, sellername, color, qty, tprice, vendorID, context}) async {
    await firestore.collection(cartCllection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'vendorID': vendorID,
      'tprice': tprice,
      'added_by': currentUser!.uid
    }).catchError((onError) {
      VxToast.show(context, msg: onError.toString());
    });
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  addToWishList(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid]),
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added To WishList");
  }

  removeFromWishList(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid]),
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed From WishList");
  }

  checkifFva(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
