import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/loading_page.dart';
import 'package:twitter_clone/common/rounded_small_button.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/view/signup_view.dart';
import 'package:twitter_clone/features/auth/widgets/auth_feild.dart';
import 'package:twitter_clone/theme/theme.dart';

import '../controller/auth_controller.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appBar = UIConstants.appBar();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  void onlogin() {
    ref.read(authControllerProvider.notifier).login(
        email: emailcontroller.text,
        password: passwordcontroller.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? Loader()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      //textfeild1
                      AuthFeild(
                        controller: emailcontroller,
                        hintText: 'Email',
                        obscureText: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //textfeild2
                      AuthFeild(
                        controller: passwordcontroller,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      SizedBox(height: 40),
                      //button
                      Align(
                        alignment: Alignment.topRight,
                        child: RoundedSmallButton(
                          onTap: onlogin,
                          label: "Done",
                          backgroundColor: Pallete.whiteColor,
                          textColor: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      //textspan
                      RichText(
                          text: TextSpan(
                              text: "Don't have an account?",
                              style: const TextStyle(fontSize: 16),
                              children: [
                            TextSpan(
                                text: " Signup",
                                style: const TextStyle(
                                    color: Pallete.blueColor, fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpView()));
                                  })
                          ]))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
