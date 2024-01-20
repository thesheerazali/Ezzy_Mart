import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_mart/Common_Widgets/appLogo_widget.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/veiw/auth/login_Screen.dart';
import 'package:get/get.dart';
import 'package:my_mart/veiw/home/home.dart';

import '../../consts/firebase_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    isUserLogin();
    super.initState();
  }

  void isUserLogin() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 3), () => Get.offAll(() => Home()));
    } else {
      Timer(const Duration(seconds: 3), () => Get.offAll(() => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
          child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg, width: 300)),
          20.heightBox,
          appLogoWidget(),
          10.heightBox,
          appname.text.fontFamily(bold).size(22).white.make(),
          appversion.text.white.make(),
          const Spacer(),
          credits.text.white.fontFamily(semibold).make(),
          30.heightBox
        ],
      )),
    );
  }
}
