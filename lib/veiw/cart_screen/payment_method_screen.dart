import 'package:get/get.dart';
import 'package:my_mart/Common_Widgets/loading_indicator.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/consts/list.dart';
import 'package:my_mart/controllers/cart_controller.dart';

import '../../Common_Widgets/out_button.dart';
import '../home/home.dart';

class PaymntMethodScreen extends StatelessWidget {
  const PaymntMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            title: "Choose Payment Method"
                .text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .make(),
          ),
          bottomNavigationBar: SizedBox(
            height: 60,
            child: controller.placingOrder.value
                ? Center(
                    child: loadingIndicator(),
                  )
                : ourButton(
                    color: redColor,
                    onPress: () async {
                      await controller.placeMyOrder(
                          orderPaymentMethod: paymentMethodListTitle[
                              controller.paymentIndex.value],
                          totalAmount: controller.totalP.value);

                      await controller.clearCart();

                      VxToast.show(context, msg: "Order Placed Successfully");
                      Get.offAll(() => const Home());
                    },
                    radiusValue: 0.0,
                    textColor: whiteColor,
                    title: "Place My Order"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(
              () => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: List.generate(paymentMethodListImg.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        paymentMethodListTitle[index]
                            .text
                            .fontFamily(bold)
                            .size(22)
                            .make(),
                        10.heightBox,
                        GestureDetector(
                          onTap: () => controller.selectPaymentMethod(index),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color:
                                        controller.paymentIndex.value == index
                                            ? redColor
                                            : Colors.transparent,
                                    width: 4)),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Image.asset(
                                  paymentMethodListImg[index],
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                controller.paymentIndex.value == index
                                    ? Transform.scale(
                                        scale: 1.3,
                                        child: Checkbox(
                                            activeColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            value: true,
                                            onChanged: (value) {}),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          )),
    );
  }
}
