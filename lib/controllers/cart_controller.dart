import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/consts/firebase_const.dart';
import 'package:my_mart/controllers/home_controller.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  var paymentIndex = 0.obs;
  //YextContyroller for shippping deatils

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalController = TextEditingController();
  var phoneController = TextEditingController();

  late dynamic productSnapshot;
  var products = [];

  var placingOrder = false.obs;

  calculateTPrice(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  selectPaymentMethod(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductsDetails();
    await firestore.collection(orderCollection).doc().set({
      'order_code': '8436688636',
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeConteroller>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_city': cityController.text,
      'order_by_state': stateController.text,
      'order_by_postal': postalController.text,
      'order_by_phone': phoneController.text,
      'shipping_method': 'Home Delivery',
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_on_delivery': false,
      'order_deliverd': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products),
    });
    placingOrder(false);
  }

  getProductsDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'vendorID': productSnapshot[i]['vendorID'],
        'tprice': productSnapshot[i]['tprice'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCllection).doc(productSnapshot[i].id).delete();
    }
  }
}
