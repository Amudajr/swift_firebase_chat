import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:swift_chat/routes/router.gr.dart';
import 'package:swift_chat/services/database.dart';
import 'package:swift_chat/utils/app_extensions.dart';
import 'package:swift_chat/utils/capitalize.dart';
import 'package:swift_chat/utils/colours.dart';
import 'package:swift_chat/utils/constants.dart';

class RecentChatsCard extends StatefulWidget {
  const RecentChatsCard({
    super.key,
    this.chatRoomStream,
    this.myName,
  });

  // final QuerySnapshot? querySnapshot;
  final Stream? chatRoomStream;
  final String? myName;

  @override
  State<RecentChatsCard> createState() => _RecentChatsCardState();
}

class _RecentChatsCardState extends State<RecentChatsCard> {
  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    addChatRoomConvo(String userName) {
      if (userName != Constants.myNme) {
        String chatRoomId = getChatRoomId(userName, widget.myName.toString());
        context.router.push(
          MainChatRoute(
            chatRoomId: chatRoomId,
            myUsername: Constants.myNme,
            username: userName,
          ),
        );
      }
    }

    return StreamBuilder(
        stream: widget.chatRoomStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Center(
              child: CircularProgressIndicator(
                color: Colours.kPrimary,
              ),
            );
          }
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => addChatRoomConvo(
                        snapshot.data.docs[index]["chatRoomId"]
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll("${widget.myName}", ""),
                      ),
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
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colours.kPrimary),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Center(
                                          child: Text(
                                            snapshot
                                                .data.docs[index]["chatRoomId"]
                                                .toString()
                                                .replaceAll("_", "")
                                                .replaceAll(
                                                    "${widget.myName}", "")
                                                .substring(0, 2)
                                                .toUpperCase(),
                                            style: context.$style.titleLarge!
                                                .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot
                                              .data.docs[index]["chatRoomId"]
                                              .toString()
                                              .replaceAll("_", "")
                                              .replaceAll(
                                                  "${widget.myName}", "")
                                              .capitalize(),
                                          style: context.$style.titleMedium!
                                              .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        const Text('How u doing?'),
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
                                          style: context.$style.bodyMedium!
                                              .copyWith(
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
                  itemCount: snapshot.data.docs.length,
                )
              : const Center(
                  child: Text('No Recent Chats'),
                );
        });
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
