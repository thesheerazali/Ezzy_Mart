import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/consts/firebase_const.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  RxBool isCheck = false.obs;
  RxBool isLoading = false.obs;
  //Login Method

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //Sign In Method

  Future<UserCredential?> signUpMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //Store User Data

  storeUserData({name, password, email}) async {
    final uid = currentUser?.uid;
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser!.uid);

    if (uid != null) {
      store.set({
        'name': name,
        'password': password,
        'email': email,
        'imageUrl': '',
        'id': currentUser!.uid,
        'cart_count': '00',
        'order_count': '00',
        'wishlist_count': '00',
      });
    }
  }

  //signOut Method

  signOutMethod({context}) async {
    try {
      await auth.signOut().then((value) => debugPrint("signoup suucefylyy"));
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
