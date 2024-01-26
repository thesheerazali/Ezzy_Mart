import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_mart/Common_Widgets/loading_indicator.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/services/firestore_services.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getAllWishList(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Wishlist Yet"
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .makeCentered();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
