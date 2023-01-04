import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:swift_chat/general_widgets/custom_button.dart';
import 'package:swift_chat/routes/router.gr.dart';
import 'package:swift_chat/utils/app_extensions.dart';
import 'package:swift_chat/utils/colours.dart';
import 'package:swift_chat/utils/local_storage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool? isLogin = false;

  getIsLoggin() async {
    await HelperFunctions.getUserLoggin().then((value) {
      setState(() {
        isLogin = value;
      });
    });
    if (isLogin == true) {
      context.router.replace(const BottomBarRoute());
    } else {
      context.router.replace(const LoginRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/chat_back.jpg"),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/s.png"),
                  fit: BoxFit.contain,
                )),
              ),
              const SizedBox(height: 10),
              Text(
                'Swift Chat',
                style: context.$style.titleLarge!.copyWith(
                  color: Colours.kPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          'Enjoy the new experience of chatting with global friends',
                          textAlign: TextAlign.center,
                          style: context.$style.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Connect people around the world for free',
                          textAlign: TextAlign.center,
                          style: context.$style.titleSmall!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        CustomButton(
                          text: 'Get Started',
                          textColor: Colors.white,
                          color: Colours.kPrimary,
                          onTap: () => getIsLoggin(),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Powered by :',
                              style: context.$style.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              'Amuda Jr.',
                              style: context.$style.titleMedium!.copyWith(
                                color: Colours.kPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
