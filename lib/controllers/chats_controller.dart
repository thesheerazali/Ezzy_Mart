import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_mart/consts/consts.dart';
import 'package:my_mart/consts/firebase_const.dart';
import 'package:my_mart/controllers/home_controller.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatCollection);

  var frndName = Get.arguments[0];
  var frndId = Get.arguments[1];

  var senderName = Get.find<HomeConteroller>().username;
  var currentId = currentUser!.uid;

  var messageController = TextEditingController();

  var isLoading = false.obs;

  dynamic chatDocId;

  getChatId() async {
    isLoading(true);
    await chats
        .where('users', isEqualTo: {
          frndId: null,
          currentId: null,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': '',
              'users': {frndId: null, currentId: null},
              'toid': '',
              'fromId': '',
              'friend_name': frndName,
              'sender_name': senderName,
            }).then((value) {
              chatDocId = value.id;
            });
          }
        });
    isLoading(false);
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toid': frndId,
        'fromId': currentId
      });

      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId
      });
    }
  }
}
