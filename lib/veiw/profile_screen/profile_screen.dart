import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_mart/Common_Widgets/bg_widget.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/consts/firebase_const.dart';
import 'package:my_mart/consts/list.dart';
import 'package:my_mart/services/firestore_services.dart';
import 'package:my_mart/veiw/auth/login_Screen.dart';
import 'package:my_mart/veiw/profile_screen/components/detail_cards.dart';
import 'package:my_mart/veiw/profile_screen/edit_profile_screen.dart';

import '../../controllers/profile_controller.dart';
import '../../utils/toast_message.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
            body: Obx(
      () => controller.userData.value != null
          ? SafeArea(
              child: Column(children: [
                //Edit Profile

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.edit,
                      color: whiteColor,
                    ),
                  ).onTap(() {
                    Get.to(() =>
                        EditProfileScreen(data: controller.userData.value));
                  }),
                ),

                //User Detail section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      controller.userData.value!.img == ''
                          ? Image.asset(imgProfile2,
                                  width: 100, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make()
                          : Image.network(controller.userData.value!.img,
                                  width: 80, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make(),
                      10.widthBox,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.userData.value!.name.text
                              .fontFamily(semibold)
                              .white
                              .make(),
                          controller.userData.value!.email.text.white.make()
                        ],
                      )),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: whiteColor),
                        ),
                        onPressed: () async {
                          try {
                            // Set auth state persistence to NONE before sign-out.
                            await auth.setPersistence(Persistence.NONE);
                            await auth.signOut();

                            // Wait for the sign-out operation to complete before navigating.
                            await Get.offAll(() => const LoginScreen());

                            // Show a success message.
                            Get.snackbar(
                              "LOGOUT",
                              "Successfully",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor:
                                  Colors.greenAccent.withOpacity(0.7),
                            );
                          } catch (error) {
                            // Handle errors during sign-out.
                            ToastMessage.toastMessage(error.toString());
                          }
                        },
                        child: "logout".text.fontFamily(semibold).white.make(),
                      ),
                    ],
                  ),
                ),

                20.heightBox,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailCard(
                        count: controller.userData.value!.cartCount,
                        title: "In Your Cart"),
                    detailCard(
                        count: controller.userData.value!.orderCount,
                        title: "Your Orders"),
                    detailCard(
                        count: controller.userData.value!.wishListCount,
                        title: "In Your Wishlish")
                  ],
                ),

                //Button Sections

                ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: profileButtonTitle[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            leading: Image.asset(
                              profileButtonIcons[index],
                              width: 22,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(color: lightGrey);
                        },
                        itemCount: profileButtonTitle.length)
                    .box
                    .white
                    .rounded
                    .margin(const EdgeInsets.all(12))
                    .shadowSm
                    .padding(const EdgeInsets.symmetric(horizontal: 16))
                    .make()
                    .box
                    .color(redColor)
                    .make()
              ]),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    )));
  }
}
