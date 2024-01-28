import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_mart/Common_Widgets/appLogo_widget.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/veiw/auth/login_Screen.dart';
import 'package:get/get.dart';
import 'package:my_mart/veiw/home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserAuthentication();
    super.initState();
  }

  Future<void> checkUserAuthentication() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    await Future.delayed(
        const Duration(seconds: 2)); // Simulating a splash screen delay

    if (user != null) {
      // User is already signed in, navigate to the home page
      Get.off(() => const Home());
    } else {
      // User is not signed in, navigate to the login page
      Get.off(() => const LoginScreen());
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
