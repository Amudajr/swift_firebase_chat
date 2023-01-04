import 'package:auto_route/auto_route.dart';
import 'package:swift_chat/general_widgets/bottom_app_bar.dart';
import 'package:swift_chat/presentations/authentication/login/views/login.dart';
import 'package:swift_chat/presentations/authentication/register/views/register.dart';
import 'package:swift_chat/presentations/calls/pages/calls.dart';
import 'package:swift_chat/presentations/chat/pages/chat.dart';
import 'package:swift_chat/presentations/landing_page/pages/landing_page.dart';
import 'package:swift_chat/presentations/main_chat/pages/main_chat.dart';
import 'package:swift_chat/presentations/recent_chats/views/recent_chats.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      path: '/',
      name: 'landingPageRoute',
      page: LandingPage,
    ),
    AutoRoute(
      path: '/login',
      name: 'loginRoute',
      page: LoginPage,
    ),
    AutoRoute(
      path: '/register',
      name: 'registerRoute',
      page: RegisterPage,
    ),
    AutoRoute(
      path: '/mainChat',
      page: MainChat,
      name: 'mainChatRoute',
    ),
    AutoRoute(
      path: 'chat',
      name: 'chatRoute',
      page: Chat,
    ),
    AutoRoute(
      path: '/bottomBar',
      name: 'bottomBarRoute',
      page: BottomBar,
      children: [
        AutoRoute(
          path: 'recentChat',
          name: 'recentChatRoute',
          page: RecentChats,
        ),
        AutoRoute(
          path: 'calls',
          name: 'callsRoute',
          page: Calls,
        ),
      ],
    ),
  ],
)
class $AppRouter {}
