import 'package:get/get.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/veiw/category_screen/category_details.dart';
import 'package:path/path.dart';

Widget featureButton({String? title, icon, controller}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        height: 80,
        fit: BoxFit.fill,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .width(Get.width * .6)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .white
      .roundedSM
      .shadowSm
      .padding(const EdgeInsets.all(4))
      .make()
      .onTap(() {
    controller.getSubCategories(title);
    Get.to(() => CategoryDetails(title: title));
  });
}
