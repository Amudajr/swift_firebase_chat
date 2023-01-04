import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swift_chat/routes/router.gr.dart';
import 'package:swift_chat/utils/colours.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  final int currentIndex;
  final List<AppNavigationItem> items;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: -30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 175),
                child: InkResponse(
                  onTap: () => context.router.push(const ChatRoute()),
                  child: Container(
                    height: 60,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colours.kPrimary,
                    ),
                    child: const Center(
                      child: Icon(
                        Iconsax.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: items
                    .asMap()
                    .entries
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          onChanged(e.key);
                          // if (e.key == 0) {
                          //   context.navigateTo(const DashboardRouter());
                          // } else if (e.key == 1) {
                          //   context.navigateTo(const NotificationsRouter());
                          // } else if (e.key == 2) {
                          //   context.navigateTo(const MessagesRouter());
                          // } else if (e.key == 3) {
                          //   context.navigateTo(const MenuRouter());
                          // }
                        },
                        child: _AppNavigationTile(
                          item: e.value,
                          isActive: currentIndex == e.key,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppNavigationTile extends StatelessWidget {
  const _AppNavigationTile({
    Key? key,
    required this.isActive,
    required this.item,
  }) : super(key: key);

  final AppNavigationItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Column(
        children: [
          Center(
            child: Stack(
              children: [
                Icon(
                  item.icon,
                  size: 22,
                  color: isActive ? Colours.kPrimary : Colors.black,
                ),

                // if (item.hasNotification)
                //   Positioned(
                //     right: 0,
                //     top: 0,
                //     child: Container(
                //       padding: const EdgeInsets.all(1),
                //       decoration: const BoxDecoration(
                //         color: Colors.white,
                //         shape: BoxShape.circle,
                //       ),
                //       child: const Icon(
                //         Icons.circle,
                //         color: Color(0xFFFF3D00),
                //         size: 10,
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            item.labelText!,
            style: TextStyle(
              fontFamily: "DM Sans",
              fontWeight: FontWeight.w500,
              color: isActive ? Colours.kPrimary : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

class AppNavigationItem {
  AppNavigationItem({
    this.icon,
    this.hasNotification = false,
    this.labelText,
  });

  final IconData? icon;
  final bool hasNotification;
  final String? labelText;
}
