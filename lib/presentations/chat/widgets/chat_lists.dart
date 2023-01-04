import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swift_chat/routes/router.gr.dart';
import 'package:swift_chat/services/database.dart';
import 'package:swift_chat/utils/app_extensions.dart';
import 'package:swift_chat/utils/colours.dart';
import 'package:swift_chat/utils/constants.dart';
import 'package:swift_chat/utils/local_storage.dart';
import 'package:swift_chat/utils/capitalize.dart';

class ChatCard extends StatefulWidget {
  const ChatCard({
    super.key,
    this.querySnapshot,
  });

  final QuerySnapshot? querySnapshot;

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  String? myUsername;
  String? otherName;
  DatabaseMethods databaseMethods = DatabaseMethods();
  QuerySnapshot? lastMessage;
  // String chatRoomId = getChatRoomId(otherName, Constants.myNme);
  @override
  void initState() {
    getUserInfo();
    // databaseMethods.getLastMessage(chatRoomId).then((val) {
    //   lastMessage = val;
    // });
    super.initState();
  }

  getUserInfo() async {
    Constants.myNme = (await HelperFunctions.getUserName())!;
    setState(() {
      myUsername = Constants.myNme;
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseMethods databaseMethods = DatabaseMethods();

    creatChatRoomConvo(String userName) {
      if (userName != Constants.myNme) {
        String chatRoomId = getChatRoomId(userName, Constants.myNme);
        List<String> users = [userName, Constants.myNme];
        Map<String, dynamic> chatRoomMap = {
          "users": users,
          "chatRoomId": chatRoomId,
        };
        databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
        context.router.push(
          MainChatRoute(
            chatRoomId: chatRoomId,
            myUsername: Constants.myNme,
            username: userName,
          ),
        );
      }
    }

    return widget.querySnapshot == null
        ? const Center(
            child: Text('No User Found'),
          )
        : ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final user = widget.querySnapshot!.docs[index];
              return GestureDetector(
                onTap: () {
                  creatChatRoomConvo(user["name"]);
                  setState(() {
                    otherName = user["name"];
                  });
                },
                child: Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage('assets/dp.jpg'),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user["name"].toString().capitalize(),
                                    style: context.$style.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text("How u doin"),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('09:30 PM'),
                              const SizedBox(height: 10),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colours.kPrimary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  child: Text(
                                    '3',
                                    style: context.$style.bodyMedium!.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 6),
            itemCount: widget.querySnapshot!.docs.length,
          );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
