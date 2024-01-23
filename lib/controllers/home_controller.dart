import 'package:get/get.dart';
import 'package:my_mart/consts/firebase_const.dart';

class HomeConteroller extends GetxController {
  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var username = "";

  getUserName() async {
    var name = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = name;
  }
}
