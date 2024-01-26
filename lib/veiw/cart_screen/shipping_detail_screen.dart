import 'package:get/get.dart';
import 'package:my_mart/Common_Widgets/custom_textField.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/controllers/cart_controller.dart';
import 'package:my_mart/veiw/cart_screen/payment_method_screen.dart';

import '../../Common_Widgets/out_button.dart';

class ShippingDetailScreen extends StatelessWidget {
  const ShippingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            color: redColor,
            onPress: () {
              if (controller.addressController.text.length > 10) {
                Get.to(() => const PaymntMethodScreen());
              } else {
                VxToast.show(context, msg: "Fill All Fields");
              }
            },
            radiusValue: 0.0,
            textColor: whiteColor,
            title: "Continue"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            customTextField(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            customTextField(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            customTextField(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalController),
            customTextField(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
