import 'package:my_mart/Common_Widgets/bg_widget.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/controllers/products_controller.dart';
import 'package:my_mart/veiw/category_screen/item_detail.dart';

import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: title.text.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      .color(darkFontGrey)
                      .size(12)
                      .makeCentered()
                      .box
                      .white
                      .rounded
                      .size(120, 60)
                      .margin(const EdgeInsets.symmetric(horizontal: 4))
                      .make()),
            ),
          ),
          20.heightBox,
          Expanded(
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 250,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(imgP5,
                            height: 150, width: 200, fit: BoxFit.cover),
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
                        .white
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .roundedSM
                        .outerShadow
                        .padding(const EdgeInsets.all(12))
                        .make()
                        .onTap(() {
                      Get.to(const ItemDetailScreen(title: "Dummy Item"));
                    });
                  }))
        ]),
      ),
    ));
  }
}
