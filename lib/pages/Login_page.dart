import 'package:blood_donation/pages/registration_page.dart';
import 'package:blood_donation/provider/user_provider.dart';
import 'package:blood_donation/utils/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'LauncherPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailControllar = TextEditingController();
  final passwordControllar = TextEditingController();
  bool _passwordVisible = false;
  UserProvider? userProvider;
  String? msg;

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          children: [
            const Text(
              "Log in",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
                fontFamily: "Schyler",
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    child: CupertinoTextField(
                      clearButtonMode: OverlayVisibilityMode.always,
                      style: const TextStyle(color: Colors.grey),
                      placeholder: "Email Address",
                      placeholderStyle: const TextStyle(
                        color: Colors.grey,
                        fontFamily: "Schyler",
                        fontSize: 14,
                      ),
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 10,
                      ),
                      controller: emailControllar,
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 5),
                        child: Icon(
                          CupertinoIcons.mail_solid,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 5,
                    child: CupertinoTextField(
                      keyboardType: TextInputType.text,
                      obscureText: !_passwordVisible,
                      style: const TextStyle(color: Colors.grey),
                      placeholder: "Password",
                      placeholderStyle: const TextStyle(
                        color: Colors.grey,
                        fontFamily: "Schyler",
                        fontSize: 14,
                      ),
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 10,
                      ),
                      controller: passwordControllar,
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 5),
                        child: Icon(
                          CupertinoIcons.lock,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                      suffix: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot password ?",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Schyler",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: _userLogin,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 20, right: 10),
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          decoration: BoxDecoration(
                            color:  Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "LOG IN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: "Schyler",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (msg != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        msg!,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontFamily: "Schyler",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: "Schyler",
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RegistrationPage.routeName);
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: "Schyler",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF17279),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            FontAwesomeIcons.google,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, left: 15),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF17279),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            FontAwesomeIcons.facebookF,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF17279),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            FontAwesomeIcons.twitter,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _userLogin() async {
    EasyLoading.show(status: 'loading...');
    final user = await userProvider?.getUserByEmail(emailControllar.text);
    if (user == null) {
      EasyLoading.dismiss();
      setState(() {
        msg = "User Not Found Try Again or Sign Up";
      });
      return;
    }
    if(passwordControllar.text!=user.password){
      EasyLoading.dismiss();
      setState(() {
        msg = "User Password Incorrect";
      });
      return;
    }
    userProvider?.userModel=user;
    await setLoginStatus(true);
    await setUserId(user.userId!);
    Navigator.pushReplacementNamed(context, LauncherPage.routeName);
  }
}
