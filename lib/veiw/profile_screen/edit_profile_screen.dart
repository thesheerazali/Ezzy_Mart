import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_mart/Common_Widgets/bg_widget.dart';
import 'package:my_mart/Common_Widgets/custom_textField.dart';
import 'package:my_mart/Common_Widgets/out_button.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.profileImgPath.isEmpty
                  ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
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
                  color: redColor,
                  onPress: () {
                    controller.changeProfileImage(context);
                  },
                  textColor: whiteColor,
                  title: "Change"),
              const Divider(),
              20.heightBox,
              customTextField(hint: nameHint, title: name, isPass: false),
              customTextField(
                  hint: passwordHint, title: password, isPass: true),
              20.heightBox,
              SizedBox(
                width: context.screenWidth - 60,
                child: ourButton(
                    color: redColor,
                    onPress: () {},
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
