// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../general_widgets/bottom_app_bar.dart' as _i6;
import '../presentations/authentication/login/views/login.dart' as _i2;
import '../presentations/authentication/register/views/register.dart' as _i3;
import '../presentations/calls/pages/calls.dart' as _i8;
import '../presentations/chat/pages/chat.dart' as _i5;
import '../presentations/landing_page/pages/landing_page.dart' as _i1;
import '../presentations/main_chat/pages/main_chat.dart' as _i4;
import '../presentations/recent_chats/views/recent_chats.dart' as _i7;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    LandingPageRoute.name: (routeData) {
      return _i9.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LandingPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i9.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterPage(),
      );
    },
    MainChatRoute.name: (routeData) {
      final args = routeData.argsAs<MainChatRouteArgs>();
      return _i9.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i4.MainChat(
          key: args.key,
          username: args.username,
          chatRoomId: args.chatRoomId,
          myUsername: args.myUsername,
        ),
      );
    },
    ChatRoute.name: (routeData) {
      return _i9.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i5.Chat(),
      );
    },
    BottomBarRoute.name: (routeData) {
      return _i9.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i6.BottomBar(),
      );
    },
    RecentChatRoute.name: (routeData) {
      return _i9.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i7.RecentChats(),
      );
    },
    CallsRoute.name: (routeData) {
      return _i9.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i8.Calls(),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          LandingPageRoute.name,
          path: '/',
        ),
        _i9.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i9.RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
        _i9.RouteConfig(
          MainChatRoute.name,
          path: '/mainChat',
        ),
        _i9.RouteConfig(
          ChatRoute.name,
          path: 'chat',
        ),
        _i9.RouteConfig(
          BottomBarRoute.name,
          path: '/bottomBar',
          children: [
            _i9.RouteConfig(
              RecentChatRoute.name,
              path: 'recentChat',
              parent: BottomBarRoute.name,
            ),
            _i9.RouteConfig(
              CallsRoute.name,
              path: 'calls',
              parent: BottomBarRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.LandingPage]
class LandingPageRoute extends _i9.PageRouteInfo<void> {
  const LandingPageRoute()
      : super(
          LandingPageRoute.name,
          path: '/',
        );

  static const String name = 'LandingPageRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.RegisterPage]
class RegisterRoute extends _i9.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i4.MainChat]
class MainChatRoute extends _i9.PageRouteInfo<MainChatRouteArgs> {
  MainChatRoute({
    _i10.Key? key,
    required String username,
    required String chatRoomId,
    required String myUsername,
  }) : super(
          MainChatRoute.name,
          path: '/mainChat',
          args: MainChatRouteArgs(
            key: key,
            username: username,
            chatRoomId: chatRoomId,
            myUsername: myUsername,
          ),
        );

  static const String name = 'MainChatRoute';
}

class MainChatRouteArgs {
  const MainChatRouteArgs({
    this.key,
    required this.username,
    required this.chatRoomId,
    required this.myUsername,
  });

  final _i10.Key? key;

  final String username;

  final String chatRoomId;

  final String myUsername;

  @override
  String toString() {
    return 'MainChatRouteArgs{key: $key, username: $username, chatRoomId: $chatRoomId, myUsername: $myUsername}';
  }
}

/// generated route for
/// [_i5.Chat]
class ChatRoute extends _i9.PageRouteInfo<void> {
  const ChatRoute()
      : super(
          ChatRoute.name,
          path: 'chat',
        );

  static const String name = 'ChatRoute';
}

/// generated route for
/// [_i6.BottomBar]
class BottomBarRoute extends _i9.PageRouteInfo<void> {
  const BottomBarRoute({List<_i9.PageRouteInfo>? children})
      : super(
          BottomBarRoute.name,
          path: '/bottomBar',
          initialChildren: children,
        );

  static const String name = 'BottomBarRoute';
}

/// generated route for
/// [_i7.RecentChats]
class RecentChatRoute extends _i9.PageRouteInfo<void> {
  const RecentChatRoute()
      : super(
          RecentChatRoute.name,
          path: 'recentChat',
        );

  static const String name = 'RecentChatRoute';
}

/// generated route for
/// [_i8.Calls]
class CallsRoute extends _i9.PageRouteInfo<void> {
  const CallsRoute()
      : super(
          CallsRoute.name,
          path: 'calls',
        );

  static const String name = 'CallsRoute';
}
