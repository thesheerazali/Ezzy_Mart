import 'package:get/get.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/veiw/orders_screen/components/order_status_widget.dart';
import 'package:my_mart/veiw/orders_screen/components/order_placed_detail.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title:
            "Order Detail".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: redColor,
                  icon: Icons.done,
                  showDone: data['order_placed'],
                  title: 'Placed'),
              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  showDone: data['order_confirmed'],
                  title: 'Conformed'),
              orderStatus(
                  color: Colors.yellow,
                  icon: Icons.car_crash,
                  showDone: data['order_on_delivery'],
                  title: 'On Delivery'),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_outlined,
                  showDone: data['order_deliverd'],
                  title: 'Deliverd'),
              const Divider(),
              10.heightBox,

              // Detail sections
              Column(
                children: [
                  orderPlacedDetail(
                    title1: 'Order Code',
                    d1: data['order_code'],
                    title2: 'Shipping Method',
                    d2: data['shipping_method'],
                  ),
                  orderPlacedDetail(
                    title1: 'Order Date',
                    d1: intl.DateFormat()
                        .add_yMd()
                        .format(data['order_date'].toDate()),
                    title2: 'Payment Method',
                    d2: data['payment_method'],
                  ),
                  orderPlacedDetail(
                    title1: 'Payment Status',
                    d1: "Unpaid",
                    title2: 'Delivery Status',
                    d2: "Order Placed",
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Shipping Adress".text.fontFamily(bold).make(),
                                "Name: ${data['order_by_name']}".text.make(),
                                "Email: ${data['order_by_email']}".text.make(),
                                "Address: ${data['order_by_address']}"
                                    .text
                                    .make(),
                                "City: ${data['order_by_city']}".text.make(),
                                "State: ${data['order_by_state']}".text.make(),
                                "Phone No: ${data['order_by_phone']}"
                                    .text
                                    .make(),
                                "Postal Code: ${data['order_by_postal']}"
                                    .text
                                    .make(),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Get.width * .28,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total Amount".text.fontFamily(bold).make(),
                                60.heightBox,
                                "${data['total_amount']}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ).box.outerShadowMd.white.make(),

              10.heightBox,

              "Ordered Details"
                  .text
                  .size(16)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlacedDetail(
                          title1:
                              "Pro-Title: ${data['orders'][index]['title']}",
                          title2: "Qty: x${data['orders'][index]['qty']}",
                          d1: "Pro-Price: ${data['orders'][index]['tprice']}",
                          d2: "Refundable"),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Color: ".text.make(),
                              Container(
                                height: 20,
                                width: 30,
                                color: Color(data['orders'][index]['color']),
                              ),
                            ],
                          )),
                      const Divider()
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .white
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
