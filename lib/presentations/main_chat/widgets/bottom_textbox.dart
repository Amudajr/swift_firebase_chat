import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swift_chat/general_widgets/custom_textbox.dart';

class BottomBox extends StatelessWidget {
  const BottomBox({
    Key? key,
    required this.messageController,
  }) : super(key: key);

  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: CustomTextBox(
          controller: messageController,
          readOnly: false,
          hintText: 'Type here...',
          radius: 30,
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Iconsax.sticker,
                  color: Colors.grey,
                ),
                SizedBox(width: 5),
                Icon(
                  Iconsax.camera,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
