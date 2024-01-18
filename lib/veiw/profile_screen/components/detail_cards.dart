import 'package:my_mart/consts/consts.dart';
import 'package:get/get.dart';

Widget detailCard({
  String? count,
  String? title,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make()
    ],
  ).box.white.rounded.width(Get.width / 3.3).height(Get.height * .090).make();
}
