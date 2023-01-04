import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swift_chat/general_widgets/custom_textbox.dart';
import 'package:swift_chat/presentations/chat/widgets/chat_lists.dart';
import 'package:swift_chat/services/database.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController searchController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  QuerySnapshot? snapshotResults;
  String? emptyString;

  @override
  void initState() {
    databaseMethods.getUserByNname(emptyString).then((val) {
      setState(() {
        snapshotResults = val;
      });
    });

    super.initState();
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
                      hintText: 'Search Message..',
                      prefixIcon: const Icon(Iconsax.search_normal),
                      controller: searchController,
                      // onChanged: (val) {
                      //   databaseMethods.getUserByNname(val);
                      //   snapshotResults = val as QuerySnapshot<Object?>;
                      // },
                      onEditingComplete: () {
                        databaseMethods
                            .getUserByNname(searchController.text)
                            .then((val) {
                          setState(() {
                            snapshotResults = val;
                          });
                        });
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
                          context.navigateBack();
                        },
                        child: const Icon(
                          Iconsax.arrow_circle_left,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ChatCard(
                  querySnapshot: snapshotResults,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
