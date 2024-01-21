import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/controllers/home_controller.dart';
import 'package:my_mart/veiw/cart_screen/cart_screen.dart';
import 'package:my_mart/veiw/category_screen/category_screen.dart';
import 'package:my_mart/veiw/home/home_screen.dart';
import 'package:my_mart/veiw/profile_screen/profile_screen.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeConteroller());
    var navBar = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: "Home"),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: "Categories"),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: "Cart"),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: "Profile")
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(
              child: navBody.elementAt(controller.currentNavIndex.value))),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: redColor,
          selectedLabelStyle: const TextStyle(fontFamily: bold),
          items: navBar,
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
