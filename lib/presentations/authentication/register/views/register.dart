import 'package:auto_route/auto_route.dart';
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    signUp() {
      if (formKey.currentState!.validate()) {
        Map<String, String> userInfoMap = {
          "email": emailController.text,
          "name": userNameController.text,
        };

        HelperFunctions.saveUserName(userNameController.text);
        HelperFunctions.saveUserEmail(emailController.text);

        setState(() {
          isLoading = true;
        });
        authMethods
            .signUpWithEmailAndPassword(
                emailController.text, passwordController.text)
            .then((value) {});

        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggin(true);

        context.router.replace(const BottomBarRoute());
      }
    }

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
                    'Join Us',
                    style: context.$style.titleLarge!.copyWith(
                      color: Colours.kPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextBox(
                  readOnly: false,
                  hintText: 'Username',
                  controller: userNameController,
                  validator: Validators.notEmpty(),
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
                isLoading
                    ? DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colours.kPrimary,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : CustomButton(
                        text: 'Sign Up',
                        textColor: Colors.white,
                        onTap: () => signUp(),
                        color: Colours.kPrimary,
                      ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have an Account?",
                      style: context.$style.titleMedium,
                    ),
                    const SizedBox(width: 5),
                    InkResponse(
                      onTap: () => context.router.push(const LoginRoute()),
                      child: Text(
                        "Login",
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
          )),
    );
  }
}
