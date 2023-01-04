import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:swift_chat/services/database.dart';
import 'package:swift_chat/utils/app_extensions.dart';
import 'package:swift_chat/utils/colours.dart';
import 'package:intl/intl.dart';

class MainChatList extends StatefulWidget {
  const MainChatList({
    super.key,
    required this.chatRoomId,
    required this.message,
    required this.myUsername,
    required this.messageMap,
  });

  final String chatRoomId;
  final String message;
  final String myUsername;
  final Map messageMap;

  @override
  State<MainChatList> createState() => _MainChatListState();
}

class _MainChatListState extends State<MainChatList> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream? chatMessages;

  @override
  void initState() {
    databaseMethods.getConvo(widget.chatRoomId).then((val) {
      setState(() {
        chatMessages = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: chatMessages,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colours.kPrimary,
              ),
            );
          }
          return snapshot.data.docs.length < 1
              ? const Center(
                  child: Text('No Chats Yet'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    final docs = snapshot.data.docs;
                    final message = docs[i].data();
                    final messageTime = message['messageTime'].toDate();
                    DateTime now = DateTime.now();
                    final today = DateTime(
                        messageTime.year, messageTime.month, messageTime.day);
                    String formattedDate;
                    final dateTime = DateFormat('h:mm a').format(messageTime);
                    if (today == DateTime(now.year, now.month, now.day)) {
                      formattedDate = 'Today $dateTime';
                    } else if (today ==
                        DateTime(now.year, now.month, now.day - 1)) {
                      formattedDate = 'Yesterday $dateTime';
                    } else {
                      formattedDate = DateFormat('EEEE, MMM d, yyyy h:mm a')
                          .format(messageTime);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BubbleNormal(
                          text: message['message'].toString(),
                          textStyle: context.$style.bodyMedium!.copyWith(
                            color: message['sentBy'] == widget.myUsername
                                ? Colors.white
                                : Colors.white,
                          ),
                          color: message['sentBy'] == widget.myUsername
                              ? Colours.kPrimary
                              : Colors.grey,
                          // delivered: true,
                          isSender: message['sentBy'] == widget.myUsername
                              ? true
                              : false,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 2),
                          child: Align(
                              alignment: message['sentBy'] == widget.myUsername
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Text(formattedDate)),
                        ),
                      ],
                    );
                  },
                  itemCount: snapshot.data.docs.length,
                );
        });
  }
}
