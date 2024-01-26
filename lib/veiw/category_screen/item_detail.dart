import 'package:get/get.dart';
import 'package:my_mart/Common_Widgets/out_button.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/consts/list.dart';
import 'package:my_mart/veiw/chat_screen/chat_screen.dart';

import '../../controllers/products_controller.dart';

class ItemDetailScreen extends StatelessWidget {
  final String title;
  final dynamic data;
  const ItemDetailScreen({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return PopScope(
      canPop: true,
      onPopInvoked: (_) async {
        controller.resetValues();
      },
      child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  controller.resetValues();
                  Get.back();
                }),
            title: title.text.color(darkFontGrey).fontFamily(bold).make(),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
              Obx(
                () => IconButton(
                    onPressed: () {
                      if (controller.isFav.value) {
                        controller.removeFromWishList(data.id, context);
                      } else {
                        controller.addToWishList(data.id, context);
                      }
                    },
                    icon: Icon(
                      Icons.favorite_outlined,
                      color: controller.isFav.value ? redColor : darkFontGrey,
                    )),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                          autoPlay: true,
                          viewportFraction: 1.0,
                          aspectRatio: 16 / 9,
                          itemCount: data['p_imgs'].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data['p_imgs'][index],
                              width: double.infinity,
                              fit: BoxFit.fill,
                            );
                          }),

                      10.heightBox,
                      //title and dtail section

                      title.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),

                      10.heightBox,

                      //rating

                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        maxRating: 5,
                        size: 25,
                      ),

                      10.heightBox,

                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),

                      10.heightBox,

                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller"
                                  .text
                                  .color(redColor)
                                  .fontFamily(semibold)
                                  .make(),
                              5.heightBox,
                              "${data['p_seller']}"
                                  .text
                                  .color(darkFontGrey)
                                  .fontFamily(semibold)
                                  .make()
                            ],
                          )),
                          const CircleAvatar(
                            backgroundColor: whiteColor,
                            child: Icon(Icons.message_rounded,
                                color: darkFontGrey),
                          ).onTap(() async {
                            Get.to(() => const ChatScreen(), arguments: [
                              data['p_seller'],
                              data['vendor_id'],
                            ]);
                          })
                        ],
                      )
                          .box
                          .height(context.screenHeight * .070)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),

                      //Color sectiom
                      20.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Color: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Row(
                                  children: List.generate(
                                      data['p_colors'].length,
                                      (index) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              VxBox()
                                                  .size(40, 40)
                                                  .roundedFull
                                                  .color(Color(data['p_colors']
                                                          [index])
                                                      .withOpacity(1.0))
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 4))
                                                  .make()
                                                  .onTap(() {
                                                controller
                                                    .changeColorIndex(index);
                                              }),
                                              Visibility(
                                                  visible: index ==
                                                      controller
                                                          .colorIndex.value,
                                                  child: const Icon(
                                                    Icons.done,
                                                    color: whiteColor,
                                                  ))
                                            ],
                                          )),
                                )
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            //Quintity Row

                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quintity: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decreQuantity();
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.remove)),
                                      controller.quantity.value.text
                                          .size(16)
                                          .fontFamily(bold)
                                          .color(darkFontGrey)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increaseQuantity(
                                                int.parse(data['p_quantity']));
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.add)),
                                      10.widthBox,
                                      "(${data['p_quantity']} avaible)"
                                          .text
                                          .color(textfieldGrey)
                                          .make()
                                    ],
                                  ),
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            //total amount
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                "${controller.totalPrice.value}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make()
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.white.shadowSm.make(),
                      ),

                      //description Section

                      10.heightBox,

                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      "${data['p_desc']}".text.color(darkFontGrey).make(),
                      10.heightBox,
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          itemDetailButtonList.length,
                          (index) => ListTile(
                            title: itemDetailButtonList[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            trailing: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),
                      15.heightBox,
                      "Products You may also Like"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(bold)
                          .size(16)
                          .make(),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                                6,
                                (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(imgP1,
                                            width: 150, fit: BoxFit.cover),
                                        10.heightBox,
                                        "Laptop 4gb/64gb"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        "\$600"
                                            .text
                                            .color(redColor)
                                            .fontFamily(bold)
                                            .size(16)
                                            .make()
                                      ],
                                    )
                                        .box
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 4))
                                        .white
                                        .roundedSM
                                        .padding(const EdgeInsets.all(8))
                                        .make())),
                      )
                    ],
                  ),
                ),
              )),
              SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ourButton(
                      radiusValue: 0.0,
                      color: redColor,
                      onPress: () {
                        if (controller.quantity.value < 1) {
                          Get.snackbar(
                              "Add Quantity", "Make sure quantity above 0 ",
                              colorText: whiteColor,
                              animationDuration:
                                  const Duration(milliseconds: 50),
                              duration: const Duration(seconds: 1),
                              backgroundColor: Colors.black,
                              snackPosition: SnackPosition.BOTTOM);
                        } else {
                          controller.addToCart(
                            color: data['p_colors']
                                [controller.colorIndex.value],
                            context: context,
                            img: data['p_imgs'][0],
                            qty: controller.quantity.value,
                            sellername: data['p_seller'],
                            title: data['p_name'],
                            tprice: controller.totalPrice.value,
                          );
                          Get.snackbar("Added", "To Cart successfully ",
                              colorText: whiteColor,
                              animationDuration:
                                  const Duration(milliseconds: 50),
                              duration: const Duration(seconds: 1),
                              backgroundColor: Colors.black,
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                      textColor: whiteColor,
                      title: "Add to Cart"))
            ],
          )),
    );
  }
}
