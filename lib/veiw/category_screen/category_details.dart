import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_mart/Common_Widgets/bg_widget.dart';
import 'package:my_mart/Common_Widgets/loading_indicator.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/controllers/products_controller.dart';
import 'package:my_mart/services/firestore_services.dart';
import 'package:my_mart/veiw/category_screen/item_detail.dart';

import 'package:get/get.dart';

class CategoryDetails extends StatefulWidget {
  final String title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  late ProductController controller;
  dynamic proDuctMethod;
  int activeSubcategoryIndex = 0;

  @override
  void initState() {
    controller = Get.find<ProductController>();
    switchCategory(widget.title);
    super.initState();
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      proDuctMethod = FireStoreServices.getSubCate(title);
    } else {
      proDuctMethod = FireStoreServices.getProducts(title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: widget.title.text.white.semiBold.make(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          controller.subcat.length,
                          (index) => controller.subcat[index]
                                  .toString()
                                  .text
                                  .fontFamily(bold)
                                  .color(
                                    activeSubcategoryIndex == index
                                        ? Colors
                                            .white // Change to white if active
                                        : darkFontGrey,
                                  )
                                  .size(12)
                                  .makeCentered()
                                  .box
                                  .color(
                                    activeSubcategoryIndex == index
                                        ? Colors
                                            .black // Change to black if active
                                        : Colors.white,
                                  )
                                  .rounded
                                  .size(120, 60)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .make()
                                  .onTap(() {
                                setState(() {
                                  setState(() {
                                    activeSubcategoryIndex = index;
                                    switchCategory(controller.subcat[index]);
                                  });
                                });
                              })),
                    ),
                  ),
                  20.heightBox,
                  StreamBuilder(
                    stream: proDuctMethod,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                          child: Center(
                            child: loadingIndicator(),
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Expanded(
                          child: "No Product Found"
                              .text
                              .color(darkFontGrey)
                              .makeCentered(),
                        );
                      } else {
                        var data = snapshot.data!.docs;
                        return Expanded(
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 250,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(data[index]['p_imgs'][0],
                                          height: 150,
                                          width: 200,
                                          fit: BoxFit.cover),
                                      10.heightBox,
                                      "${data[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      5.heightBox,
                                      "${data[index]['p_price']}"
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
                                      .outerShadow
                                      .padding(const EdgeInsets.all(12))
                                      .make()
                                      .onTap(() {
                                    controller.checkifFva(data[index]);
                                    Get.to(() => ItemDetailScreen(
                                          title:
                                              data[index]['p_name'].toString(),
                                          data: data[index],
                                        ));
                                  });
                                }));
                      }
                    },
                  ),
                ],
              ),
            )));
  }
}
