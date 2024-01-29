import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_mart/Common_Widgets/loading_indicator.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/consts/firebase_const.dart';
import 'package:my_mart/services/firestore_services.dart';

import '../category_screen/item_detail.dart';

class SearchSreen extends StatelessWidget {
  final String? title;
  const SearchSreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: title!.text.color(darkFontGrey).make(),
        ),
        body: FutureBuilder(
          future: FireStoreServices.searchProducts(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Product Found".text.color(redColor).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filterProduct = data
                  .where((element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()))
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 300),
                  children: filterProduct
                      .mapIndexed((currentValue, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(filterProduct[index]['p_imgs'][0],
                                  height: 200, width: 200, fit: BoxFit.cover),
                              const Spacer(),
                              "${filterProduct[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              "${filterProduct[index]['p_price']}"
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
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .roundedSM
                              .outerShadowMd
                              .padding(const EdgeInsets.all(12))
                              .make()
                              .onTap(() {
                            Get.to(
                              () => ItemDetailScreen(
                                title: "${filterProduct[index]['p_name']}",
                                data: filterProduct[index],
                              ),
                            );
                          }))
                      .toList(),
                ),
              );
            }
          },
        ));
  }
}
