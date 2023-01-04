import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swift_chat/general_widgets/custom_button.dart';
import 'package:swift_chat/general_widgets/custom_textbox.dart';
import 'package:swift_chat/routes/router.gr.dart';
import 'package:swift_chat/services/auth.dart';
import 'package:swift_chat/services/database.dart';
import 'package:swift_chat/utils/app_extensions.dart';
import 'package:swift_chat/utils/colours.dart';
import 'package:swift_chat/utils/local_storage.dart';
import 'package:swift_chat/utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  QuerySnapshot? snapshotResult;
  bool isLoading = false;

  signIn() {
    if (formKey.currentState!.validate()) {
      HelperFunctions.saveUserEmail(emailController.text);
      databaseMethods.getUserByEmail(emailController.text).then((val) {
        setState(() {
          snapshotResult = val;
        });
        HelperFunctions.saveUserName(snapshotResult!.docs[0]["name"]);
      });

      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((value) {
        if (value != null) {
          HelperFunctions.saveUserLoggin(true);
          context.router.replace(const BottomBarRoute());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Login Now',
                  style: context.$style.titleLarge!.copyWith(
                    color: Colours.kPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextBox(
                readOnly: false,
                hintText: 'Email',
                controller: emailController,
                validator: Validators.email(),
              ),
              const SizedBox(height: 20),
              CustomTextBox(
                readOnly: false,
                hintText: 'Password',
                controller: passwordController,
                validator: Validators.notEmpty(),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Sign in',
                textColor: Colors.white,
                onTap: () => signIn(),
                color: Colours.kPrimary,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Sign in with Google',
                textColor: Colors.white,
                onTap: () => context.router.push(
                  const BottomBarRoute(),
                ),
                color: Colors.black,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have Account?",
                    style: context.$style.titleMedium,
                  ),
                  const SizedBox(width: 5),
                  InkResponse(
                    onTap: () => context.router.push(const RegisterRoute()),
                    child: Text(
                      "Register Now",
                      style: context.$style.titleMedium!.copyWith(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
