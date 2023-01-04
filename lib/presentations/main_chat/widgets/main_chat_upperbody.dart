import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swift_chat/routes/router.gr.dart';
import 'package:swift_chat/utils/app_extensions.dart';
import 'package:swift_chat/utils/capitalize.dart';
import 'package:swift_chat/utils/colours.dart';

class MainChatUpperBody extends StatelessWidget {
  const MainChatUpperBody({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: Row(
          children: [
            IconButton(
              onPressed: () => context.router.replace(const BottomBarRoute()),
              icon: const Icon(Iconsax.arrow_left),
            ),
            const SizedBox(width: 5),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colours.kPrimary,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  username.toUpperCase().substring(0, 2),
                  style: context.$style.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username.capitalize(),
                  style: context.$style.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Online',
                  style: context.$style.titleMedium!.copyWith(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Iconsax.video,
              color: Colors.grey,
            ),
            const SizedBox(width: 15),
            const Icon(
              Iconsax.call,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
