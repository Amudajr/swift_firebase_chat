import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swift_chat/general_widgets/custom_textbox.dart';
import 'package:swift_chat/presentations/recent_chats/widgets/recent_chat_list.dart';
import 'package:swift_chat/routes/router.gr.dart';
import 'package:swift_chat/services/auth.dart';
import 'package:swift_chat/services/database.dart';
import 'package:swift_chat/utils/constants.dart';
import 'package:swift_chat/utils/local_storage.dart';

class RecentChats extends StatefulWidget {
  const RecentChats({super.key});

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchController = TextEditingController();

  Stream? chatRoomStream;
  String? myName;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myNme = (await HelperFunctions.getUserName())!;
    setState(() {
      myName = Constants.myNme;
    });
    databaseMethods.getChatRooms(Constants.myNme).then((val) {
      chatRoomStream = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .75,
                    child: CustomTextBox(
                      readOnly: false,
                      hintText: 'Search User...',
                      prefixIcon: const Icon(Iconsax.search_normal),
                      controller: searchController,
                      // onChanged: (val) {
                      //   databaseMethods.getUserByNname(val);
                      //   snapshotResults = val as QuerySnapshot<Object?>;
                      // },
                      onEditingComplete: () {
                        if (searchController.text != '') {
                          databaseMethods
                              .getChatRooms(searchController.text)
                              .then((val) {
                            setState(() {
                              chatRoomStream = val;
                            });
                          });
                        } else {
                          databaseMethods
                              .getChatRooms(myName.toString())
                              .then((val) {
                            setState(() {
                              chatRoomStream = val;
                            });
                          });
                        }
                      },
                    ),
                  ),
                  Card(
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 13),
                      child: InkResponse(
                        onTap: () {
                          context.router.replace(const LoginRoute());
                          HelperFunctions.saveUserLoggin(false);
                          authMethods.signOut();
                        },
                        child: const Icon(
                          Iconsax.logout_1,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: RecentChatsCard(
                  chatRoomStream: chatRoomStream,
                  myName: myName,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
