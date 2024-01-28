import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/veiw/orders_screen/components/order_Status_widget.dart';
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
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Adress".text.fontFamily(bold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_postal']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(bold).make(),
                              25.heightBox,
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
            ).box.outerShadowMd.white.make()
          ],
        ),
      ),
    );
  }
}
