import 'package:my_mart/Common_Widgets/bg_widget.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/consts/list.dart';
import 'package:my_mart/controllers/products_controller.dart';
import 'package:my_mart/veiw/category_screen/category_details.dart';

import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: "Category".text.white.make(),
            ),
            body: Container(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 200,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Image.asset(categoriesImgList[index],
                            height: 120, width: 200, fit: BoxFit.cover),
                        10.heightBox,
                        categoriesTitleList[index]
                            .text
                            .align(TextAlign.center)
                            .color(darkFontGrey)
                            .make()
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .clip(Clip.antiAlias)
                        .padding(const EdgeInsets.symmetric(horizontal: 4))
                        .outerShadow
                        .make()
                        .onTap(() {
                      controller.getSubCategories(categoriesTitleList[index]);
                      Get.to(() =>
                          CategoryDetails(title: categoriesTitleList[index]));
                    });
                  }),
            )));
  }
}
