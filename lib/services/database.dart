import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByNname(String? username) async {
    try {
      if (username != '') {
        return await FirebaseFirestore.instance
            .collection("users")
            .where("name", isEqualTo: username)
            .get();
      } else {
        return await FirebaseFirestore.instance.collection("users").get();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getRecentUserByNname(String? username) async {
    try {
      if (username != '') {
        return await FirebaseFirestore.instance
            .collection("recent_chats")
            .where("name", isEqualTo: username)
            .get();
      } else {
        return await FirebaseFirestore.instance
            .collection("recent_chats")
            .get();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getUserByEmail(String? email) async {
    try {
      if (email != '') {
        return await FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: email)
            .get();
      } else {
        return await FirebaseFirestore.instance.collection("users").get();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getRecentUserByEmail(String? email) async {
    try {
      if (email != '') {
        return await FirebaseFirestore.instance
            .collection("recent_chats")
            .where("email", isEqualTo: email)
            .get();
      } else {
        return await FirebaseFirestore.instance
            .collection("recent_chats")
            .get();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  updateRecentChats(userMap) {
    FirebaseFirestore.instance.collection("recent_chats").add(userMap);
  }

  createChatRoom(String? chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  //  addChatRoom(String? chatRoomId) {
  //   FirebaseFirestore.instance
  //       .collection("chatRoom").add(data)
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }

  getConvo(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time")
        .snapshots();
  }

  getLastMessage(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .limit(1);
  }

  getChatRooms(String username) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where("users", arrayContains: username)
        .snapshots();
  }

  // getlastMessage(String chatRoomId) async {
  //   return await FirebaseFirestore.instance.collection("chatRoom").where("users", )
  // }

  addConvo(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }
}
