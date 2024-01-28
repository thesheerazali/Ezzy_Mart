import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_mart/Common_Widgets/loading_indicator.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/services/firestore_services.dart';
import 'package:my_mart/veiw/orders_screen/orders_detail_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Orders"
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Get.to(
                    () => OrdersDetails(
                      data: data[index],
                    ),
                  ),
                  leading: '${index + 1}'
                      .text
                      .color(darkFontGrey)
                      .fontFamily(bold)
                      .xl3
                      .make(),
                  title: data[index]['order_code']
                      .toString()
                      .text
                      .color(redColor)
                      .fontFamily(semibold)
                      .make(),
                  subtitle: data[index]['total_amount']
                      .toString()
                      .numCurrency
                      .text
                      .color(darkFontGrey)
                      .fontFamily(bold)
                      .make(),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios_rounded)),
                );
              },
            );
          }
        },
      ),
    );
  }
}
