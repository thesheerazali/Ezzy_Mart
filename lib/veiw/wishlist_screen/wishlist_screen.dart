import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_mart/Common_Widgets/loading_indicator.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/consts/firebase_const.dart';
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
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(
                        "${data[index]['p_imgs'][0]}",
                        fit: BoxFit.cover,
                        width: 80,
                      ),
                      title: "${data[index]['p_name']}}"
                          .text
                          .fontFamily(semibold)
                          .size(16)
                          .make(),
                      subtitle: "${data[index]['p_price']}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(semibold)
                          .make(),
                      trailing: const Icon(
                        Icons.favorite,
                        color: redColor,
                      ).onTap(() async {
                        await firestore
                            .collection(productsCollection)
                            .doc(data[index].id)
                            .set({
                          'p_wishlist':
                              FieldValue.arrayRemove([currentUser!.uid])
                        }, SetOptions(merge: true));
                      }),
                    );
                  },
                )),
              ],
            );
          }
        },
      ),
    );
  }
}
