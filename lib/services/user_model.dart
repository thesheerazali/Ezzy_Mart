import 'package:get/get_connect/http/src/request/request.dart';

class UserProfile {
  final String email;

  final String name;
  final String cartCount;
  final String orderCount;
  final String wishListCount;
  final String img;

  // final String profileImageUrl;

  UserProfile({
    required this.name,
    required this.email,
    required this.cartCount,
    required this.orderCount,
    required this.wishListCount,
    required this.img,

    // this.profileImageUrl,
  });

  factory UserProfile.fromFirestore(Map<String, dynamic> data) {
    return UserProfile(
        // Assuming 'uid' is a field in your Firestore document
        // Replace with the actual field name
        name: data['name'],
        email: data['email'], // Replace with the actual field name
        img: data['imageUrl'],
        cartCount: data['cart_count'],
        orderCount: data['order_count'],
        wishListCount: data['wishlist_count']
        //  profileImageUrl: data['profileImageUrl'] ?? '', // Replace with the actual field name
        );
  }
}
