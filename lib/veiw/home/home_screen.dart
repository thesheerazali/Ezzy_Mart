import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_mart/Common_Widgets/home_buttons.dart';
import 'package:my_mart/Common_Widgets/loading_indicator.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/consts/list.dart';
import 'package:my_mart/services/firestore_services.dart';
import 'package:my_mart/veiw/category_screen/item_detail.dart';
import 'package:my_mart/veiw/home/components/featured_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              // height: 60,
              color: lightGrey,
              child: TextFormField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    // focusedBorder:
                    //     OutlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: "Search anything..",
                    hintStyle: TextStyle(color: textfieldGrey)),
              ),
            ),

            //swiper Brands
            10.heightBox,

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        height: context.screenHeight * .19,
                        enlargeCenterPage: true,
                        itemCount: brandsPosters.length,
                        itemBuilder: (context, index) {
                          return Image.asset(brandsPosters[index],
                                  fit: BoxFit.fill)
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    10.heightBox,

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            2,
                            (index) => homeButtons(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 2.5,
                                icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                title: index == 0
                                    ? "Today Deals"
                                    : "Flash Sell"))),

                    10.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        height: context.screenHeight * .18,
                        enlargeCenterPage: true,
                        itemCount: brandsPosters.length,
                        itemBuilder: (context, index) {
                          return Image.asset(brandsPosters2[index],
                                  fit: BoxFit.fill)
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    10.heightBox,

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                            (index) => homeButtons(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 3.5,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icTopSeller,
                                title: index == 0
                                    ? "Top Categories"
                                    : index == 1
                                        ? "Top Brands"
                                        : "Top Sellers"))),

                    //featured Ctategories

                    20.heightBox,

                    Align(
                        alignment: Alignment.centerLeft,
                        child: "Featured Categories"
                            .text
                            .color(darkFontGrey)
                            .size(18)
                            .fontFamily(semibold)
                            .make()),

                    20.heightBox,

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(
                              3,
                              (index) => Column(
                                    children: [
                                      featureButton(
                                          icon: featuredImages1[index],
                                          title: featuredTitle1[index]),
                                      10.heightBox,
                                      featureButton(
                                          icon: featuredImages2[index],
                                          title: featuredTitle2[index]),
                                    ],
                                  ))),
                    ),

                    //featured Products
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Featured Products"
                                .text
                                .white
                                .size(18)
                                .fontFamily(bold)
                                .make(),
                            10.heightBox,
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
                                                  width: 150,
                                                  fit: BoxFit.cover),
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
                                              .margin(
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4))
                                              .white
                                              .roundedSM
                                              .padding(const EdgeInsets.all(8))
                                              .make())),
                            )
                          ]),
                    ),
                    20.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        height: context.screenHeight * .18,
                        enlargeCenterPage: true,
                        itemCount: brandsPosters.length,
                        itemBuilder: (context, index) {
                          return Image.asset(brandsPosters2[index],
                                  fit: BoxFit.fill)
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    //All Products
                    20.heightBox,

                    Align(
                        alignment: Alignment.centerLeft,
                        child: "All Products"
                            .text
                            .color(darkFontGrey)
                            .size(18)
                            .fontFamily(bold)
                            .make()),
                    20.heightBox,
                    StreamBuilder(
                      stream: FireStoreServices.getAllProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: loadingIndicator());
                        } else {
                          var allProductData = snapshot.data!.docs;
                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allProductData.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 300),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                        allProductData[index]['p_imgs'][0],
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.cover),
                                    const Spacer(),
                                    "${allProductData[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    "${allProductData[index]['p_price']}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make()
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .roundedSM
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  Get.to(
                                    () => ItemDetailScreen(
                                      title:
                                          "${allProductData[index]['p_name']}",
                                      data: allProductData[index],
                                    ),
                                  );
                                });
                              });
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
