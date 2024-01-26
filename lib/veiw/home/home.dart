import 'package:flutter/services.dart';
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
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didpop) async {
        if (controller.currentNavIndex.value != 0) {
          controller.currentNavIndex.value = 0;
        } else if (!didpop) {
          showExitConfirmationDialog(context);
        }
      },
      child: Scaffold(
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
      ),
    );
  }

  Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Exit Confirmation"),
            content: Text("Are you sure you want to exit the application?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("No"),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text("Yes"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
