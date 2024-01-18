import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_mart/Common_Widgets/bg_widget.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/consts/firebase_const.dart';
import 'package:my_mart/consts/list.dart';
import 'package:my_mart/controllers/auth_controller.dart';
import 'package:my_mart/controllers/profile_controller.dart';
import 'package:my_mart/services/firestore_services.dart';
import 'package:my_mart/veiw/auth/login_Screen.dart';
import 'package:my_mart/veiw/profile_screen/components/detail_cards.dart';
import 'package:my_mart/veiw/profile_screen/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FireStoreServices.getUserData(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          );
        } else {
          var data = snapshot.data!.docs[0];
          return SafeArea(
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
                  Get.to(() => const EditProfileScreen());
                }),
              ),

              //User Detail section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make(),
                    10.widthBox,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "${data['name']}"
                            .text
                            .fontFamily(semibold)
                            .white
                            .make(),
                        "${data['email']}".text.white.make()
                      ],
                    )),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: whiteColor)),
                        onPressed: () async {
                          await Get.put(AuthController())
                              .signOutMethod(context: context);
                          Get.offAll(() => const LoginScreen());
                        },
                        child: "logout".text.fontFamily(semibold).white.make())
                  ],
                ),
              ),

              20.heightBox,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  detailCard(count: "00".toString(), title: "In Your Cart"),
                  detailCard(count: "647".toString(), title: "Your Orders"),
                  detailCard(count: "32".toString(), title: "In Your Wishlish")
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
          );
        }
      },
    )));
  }
}
