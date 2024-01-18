import 'package:get/get.dart';
import 'package:my_mart/controllers/auth_controller.dart';

import '../../Common_Widgets/applogo_widget.dart';
import '../../Common_Widgets/bg_widget.dart';
import '../../Common_Widgets/custom_textField.dart';
import '../../Common_Widgets/out_button.dart';
import '../../consts/consts.dart';
import '../../consts/list.dart';

import '../home/home.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Obx(
                () => Column(children: [
                  (context.screenHeight * 0.1).heightBox,
                  appLogoWidget(),
                  12.heightBox,
                  "Login To $appname"
                      .text
                      .fontFamily(bold)
                      .white
                      .size(18)
                      .make(),
                  15.heightBox,
                  Column(
                    children: [
                      customTextField(
                          title: email,
                          hint: emailHint,
                          isPass: false,
                          controller: controller.emailController),
                      customTextField(
                          title: password,
                          hint: passwordHint,
                          isPass: true,
                          controller: controller.passwordController),

                      //forgetPassword Buttom

                      Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                              onPressed: () {},
                              child: "Forget Password".text.make())),

                      5.heightBox,

                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                                  color: redColor,
                                  onPress: () async {
                                    controller.isLoading(true);
                                    await controller
                                        .loginMethod(context: context)
                                        .then((value) {
                                      if (value != null) {
                                        Get.snackbar("Login", "Successfully");
                                        Get.offAll(() => const Home());
                                      } else {
                                        controller.isLoading(false);
                                      }
                                    });
                                  },
                                  textColor: whiteColor,
                                  title: login)
                              .box
                              .width(context.screenWidth - 50)
                              .make(),

                      5.heightBox,

                      createNewAcc.text.color(fontGrey).make(),

                      5.heightBox,

                      ourButton(
                              color: lightGolden,
                              onPress: () {
                                Get.to(() => SignUpScreen());
                              },
                              textColor: lightGolden,
                              title: signUp)
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                      10.heightBox,

                      loginWith.text.make(),

                      10.heightBox,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: lightGrey,
                                    radius: 25,
                                    child: Image.asset(
                                      socialIconList[index],
                                      width: 30,
                                    ),
                                  ),
                                )),
                      )
                    ],
                  )
                      .box
                      .white
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .rounded
                      .shadowSm
                      .make()
                ]),
              ),
            )));
  }
}
