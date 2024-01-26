import 'package:get/get.dart';
import 'package:my_mart/consts/consts.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  var paymentIndex = 0.obs;
  //YextContyroller for shippping deatils

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalController = TextEditingController();
  var phoneController = TextEditingController();

  calculateTPrice(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  selectPaymentMethod(index) {
    paymentIndex.value = index;
  }
}
