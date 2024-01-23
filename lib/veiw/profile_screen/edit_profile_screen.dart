import 'dart:io';

import 'package:get/get.dart';
import 'package:my_mart/Common_Widgets/bg_widget.dart';
import 'package:my_mart/Common_Widgets/custom_textField.dart';
import 'package:my_mart/Common_Widgets/out_button.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/controllers/products_controller.dart';
import 'package:my_mart/controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    controller.nameController.text = data['name'];

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
                  : data['imageUrl'] != "" && controller.profileImgPath.isEmpty
                      ? Image.network(data['imageUrl'],
                              width: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      : Image.file(
                              File(
                                controller.profileImgPath.value,
                              ),
                              width: 100,
                              fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),
              10.heightBox,
              ourButton(
                  radiusValue: 10.0,
                  color: redColor,
                  onPress: () {
                    controller.changeProfileImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change"),
              const Divider(),
              20.heightBox,
              customTextField(
                  hint: nameHint,
                  title: name,
                  isPass: false,
                  controller: controller.nameController),
              customTextField(
                  hint: passwordHint,
                  title: "Old Password",
                  isPass: true,
                  controller: controller.oldPassController),
              10.heightBox,
              customTextField(
                  hint: passwordHint,
                  title: "New Password",
                  isPass: true,
                  controller: controller.newPassController),
              20.heightBox,
              controller.isloading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                          radiusValue: 10.0,
                          color: redColor,
                          onPress: () async {
                            controller.isloading(true);

                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImgLink = data['imageUrl'];
                            }

                            if (data['password'] ==
                                controller.oldPassController.text) {
                              controller.changeAuthPasswird(
                                  email: data['email'],
                                  password: controller.oldPassController.text,
                                  newPassword:
                                      controller.newPassController.text);
                              await controller.updateProfile(
                                  imgUrl: controller.profileImgLink,
                                  name: controller.nameController.text,
                                  password: controller.newPassController.text);
                              VxToast.show(context, msg: "Updated");
                            } else {
                              VxToast.show(context, msg: "Wrong Old Password");
                              controller.isloading(false);
                            }
                          },
                          textColor: whiteColor,
                          title: "Save"),
                    ),
            ],
          )
              .box
              .shadowSm
              .white
              .rounded
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .make(),
        ),
      ),
    );
  }
}
