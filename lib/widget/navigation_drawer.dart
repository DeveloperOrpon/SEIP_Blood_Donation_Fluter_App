import 'dart:io';

import 'package:blood_donation/provider/user_provider.dart';
import 'package:blood_donation/utils/style.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:blood_donation/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../pages/LauncherPage.dart';
import '../utils/helper_function.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  NavigationProvider? provider;
  UserProvider? userProvider;

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) =>ClipPath(
        clipper: OvalRightBorderClipper(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 40),
            decoration: inputDecoration,
            width: 300,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                        icon: const Icon(
                          Icons.power_settings_new,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          await setLoginStatus(false);
                          Navigator.pushReplacementNamed(
                              context, LauncherPage.routeName);
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        provider.currentIndex=3;
                      },
                      child: Container(
                        height: 90,
                        width: 90,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.orange),
                          image: DecorationImage(
                              image:
                                  FileImage(File(userProvider!.userModel.imageUrl)),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "${userProvider!.userModel.firstName} ${userProvider!.userModel.lastName}",
                      style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(userProvider!.userModel.email,
                        style: TextStyle(
                            color: appStore.textPrimaryColor, fontSize: 16.0)),
                    const SizedBox(height: 30),
                    itemList(
                        context,
                        const Icon(
                          Icons.home,
                          color: Colors.red,
                          size: 40,
                        ),
                        "Home"),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    itemList(
                        context,
                        Icon(
                          Icons.person_pin,
                          color: Colors.red,
                          size: 40,
                        ),
                        "My Profile"),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    itemList(
                        context,
                        Icon(
                          Icons.message,
                          color: Colors.red,
                          size: 40,
                        ),
                        "Messages"),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                    itemList(
                        context,
                        const Icon(
                          Icons.info_outline,
                          color: Colors.red,
                          size: 40,
                        ),
                        "Help Admin"),
                    const Divider(),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget itemList(BuildContext context, Widget icon, String title) {
  return InkWell(
    onTap: () {
      final provider=Provider.of<NavigationProvider>(context,listen: false);
      if (title == "Home") Scaffold.of(context).closeDrawer();
      if (title ==  "My Profile") {
        Scaffold.of(context).closeDrawer();
        provider.currentIndex=3;
      }
      if (title == "Help Admin") {
        Scaffold.of(context).closeDrawer();
        showCorrectMsg("Your Help Request Successful ", context);
      }
      if (title == "Messages") {
        Scaffold.of(context).closeDrawer();
        showErrorMsg("You Have No Meeage", context);
      }
    },
    child: Row(
      children: [
        icon,
        SizedBox(
          width: 10,
        ),
        Text(title, style: TextStyle(color: appStore.textPrimaryColor)),
      ],
    ),
  );
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

AppStore appStore = AppStore();

class AppStore {
  Color? textPrimaryColor;
  Color? iconColorPrimaryDark;
  Color? scaffoldBackground;
  Color? backgroundColor;
  Color? backgroundSecondaryColor;
  Color? appColorPrimaryLightColor;
  Color? textSecondaryColor;
  Color? appBarColor;
  Color? iconColor;
  Color? iconSecondaryColor;
  Color? cardColor;

  AppStore() {
    textPrimaryColor = Color(0xFF212121);
    iconColorPrimaryDark = Color(0xFF212121);
    scaffoldBackground = Color(0xFFEBF2F7);
    backgroundColor = Colors.black;
    backgroundSecondaryColor = Color(0xFF131d25);
    appColorPrimaryLightColor = Color(0xFFF9FAFF);
    textSecondaryColor = Color(0xFF5A5C5E);
    appBarColor = Colors.white;
    iconColor = Color(0xFF212121);
    iconSecondaryColor = Color(0xFFA8ABAD);
    cardColor = Color(0xFF191D36);
  }
}
