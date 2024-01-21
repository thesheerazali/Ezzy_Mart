import 'package:get/get.dart';
import 'package:my_mart/controllers/auth_controller.dart';
import 'package:my_mart/veiw/home/home.dart';

import '../../Common_Widgets/appLogo_widget.dart';
import '../../Common_Widgets/bg_widget.dart';
import '../../Common_Widgets/custom_textField.dart';
import '../../Common_Widgets/out_button.dart';
import '../../consts/consts.dart';
import '../../consts/firebase_const.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final controller = Get.put(AuthController());

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordReController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(children: [
                (context.screenHeight * 0.1).heightBox,
                appLogoWidget(),
                12.heightBox,
                "Join The $appname".text.fontFamily(bold).white.size(18).make(),
                15.heightBox,
                Obx(
                  () => Column(
                    children: [
                      customTextField(
                          title: name,
                          hint: nameHint,
                          controller: nameController,
                          isPass: false),
                      customTextField(
                          title: email,
                          hint: emailHint,
                          controller: emailController,
                          isPass: false),
                      customTextField(
                          title: password,
                          hint: passwordHint,
                          controller: passwordController,
                          isPass: true),
                      customTextField(
                          title: retypePass,
                          hint: passwordHint,
                          controller: passwordReController,
                          isPass: true),
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                                activeColor: redColor,
                                checkColor: whiteColor,
                                value: controller.isCheck.value,
                                onChanged: (newValue) {
                                  controller.isCheck.value = newValue!;
                                }),
                          ),
                          5.widthBox,
                          Expanded(
                            child: RichText(
                                text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                        color: fontGrey, fontFamily: semibold)),
                                TextSpan(
                                    text: "Terms and Conditions",
                                    style: TextStyle(
                                        color: redColor, fontFamily: semibold)),
                                TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                        color: fontGrey, fontFamily: semibold)),
                                TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                        color: redColor, fontFamily: semibold)),
                              ],
                            )),
                          ),
                        ],
                      ),
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                                  radiusValue: 10.0,
                                  color: controller.isCheck.value == true
                                      ? redColor
                                      : lightGrey,
                                  onPress: () async {
                                    if (controller.isCheck.value != false) {
                                      controller.isLoading(true);
                                      try {
                                        await controller
                                            .signUpMethod(
                                                context: context,
                                                email: emailController.text,
                                                password:
                                                    passwordController.text)
                                            .then((value) {
                                          return controller.storeUserData(
                                              email: emailController.text,
                                              name: nameController.text,
                                              password:
                                                  passwordController.text);
                                        }).then((value) {
                                          VxToast.show(context,
                                              msg: "LogIn Successfully");
                                          return Get.offAll(() => const Home());
                                        });
                                      } catch (e) {
                                        auth.signOut();
                                        VxToast.show(context,
                                            msg: e.toString());
                                        controller.isLoading(false);
                                      }
                                    }
                                  },
                                  textColor: controller.isCheck.value == true
                                      ? whiteColor
                                      : darkFontGrey,
                                  title: signUp)
                              .box
                              .width(context.screenWidth - 50)
                              .make(),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "Already Have Account? "
                              .text
                              .fontFamily(bold)
                              .color(fontGrey)
                              .make(),
                          "Log In "
                              .text
                              .fontFamily(bold)
                              .color(redColor)
                              .make()
                              .onTap(() {
                            Get.back();
                          })
                        ],
                      )
                    ],
                  )
                      .box
                      .white
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .rounded
                      .shadowSm
                      .make(),
                )
              ]),
            )));
  }
}
