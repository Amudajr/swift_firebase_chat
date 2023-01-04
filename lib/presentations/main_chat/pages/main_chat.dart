import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swift_chat/general_widgets/custom_textbox.dart';
import 'package:swift_chat/presentations/main_chat/widgets/main_chat_list.dart';
import 'package:swift_chat/presentations/main_chat/widgets/main_chat_upperbody.dart';
import 'package:swift_chat/services/database.dart';
import 'package:swift_chat/utils/constants.dart';

class MainChat extends StatefulWidget {
  const MainChat({
    super.key,
    required this.username,
    required this.chatRoomId,
    required this.myUsername,
  });

  final String username;
  final String chatRoomId;
  final String myUsername;

  @override
  State<MainChat> createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  TextEditingController messageController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  String? email;
  Stream? chatRoomStream;

  Map<String, dynamic> messageMap = {};

  Color sendButton = Colors.grey;

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messageMap = {
          "message": messageController.text,
          "sentBy": widget.myUsername,
          "time": DateTime.now().millisecondsSinceEpoch,
          "messageTime": DateTime.now(),
        };
        sendButton = Colors.grey;
      });
      databaseMethods.addConvo(widget.chatRoomId, messageMap);
      messageController.text = '';
    }
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    databaseMethods.getChatRooms(Constants.myNme).then((val) {
      chatRoomStream = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/real_chat_back.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            MainChatUpperBody(username: widget.username),
            const SizedBox(height: 10),
            Expanded(
              child: MainChatList(
                chatRoomId: widget.chatRoomId,
                message: messageController.text,
                myUsername: widget.myUsername,
                messageMap: messageMap,
              ),
            ),
            const SizedBox(height: 5),
            Card(
              elevation: 5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: CustomTextBox(
                  controller: messageController,
                  onChanged: (val) {
                    if (messageController.text.isNotEmpty) {
                      setState(() {
                        sendButton = Colors.blue;
                      });
                    } else {
                      setState(() {
                        sendButton = Colors.grey;
                      });
                    }
                  },
                  readOnly: false,
                  hintText: 'Type here...',
                  radius: 30,
                  suffixIcon: IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: Icon(
                      Iconsax.send_2,
                      color: sendButton,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
