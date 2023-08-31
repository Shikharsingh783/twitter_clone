import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/loading_page.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';

import '../../../common/rounded_small_button.dart';
import '../../../constants/constants.dart';
import '../../../theme/pallete.dart';
import '../widgets/auth_feild.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
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

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
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
          ? const Loader()
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
                          onTap: onSignUp,
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
                              text: "Already have an account?",
                              style: const TextStyle(fontSize: 16),
                              children: [
                            TextSpan(
                                text: " Login",
                                style: const TextStyle(
                                    color: Pallete.blueColor, fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginView()));
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
