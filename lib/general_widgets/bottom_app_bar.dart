import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swift_chat/general_widgets/bottom_bar_app_tile.dart';
import 'package:swift_chat/routes/router.gr.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  PageController myPage = PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
        routes: const [
          RecentChatRoute(),
          CallsRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return AppNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onChanged: tabsRouter.setActiveIndex,
            items: [
              AppNavigationItem(
                icon: Iconsax.message,
                labelText: "Chats",
              ),
              AppNavigationItem(
                icon: Iconsax.call,
                labelText: "Calls",
              ),
              //SvgPicture.asset("assets/shopping.svg")
            ],
          );
        });
  }
}
