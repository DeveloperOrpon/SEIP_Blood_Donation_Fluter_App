import 'package:blood_donation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../utils/helper_function.dart';
import 'home_page.dart';
import 'login_page.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher';

  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    EasyLoading.show(status: 'loading...');
    redirectUser();
    super.initState();
  }

  redirectUser() async {
    if (await getLoginStatus()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final id = await getUserId();
      userProvider.userModel = (await userProvider.getUserByUserId(id))!;
      if (await userProvider.getDonatePostByUserId(id) != null) {
        userProvider.bloodDonatePostModel =
            (await userProvider.getDonatePostByUserId(id))!;
      }
      userProvider.getAllDonationPost();
      Navigator.pushReplacementNamed(context, HomePage.routeName);
      EasyLoading.dismiss();
    } else {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
