import 'package:blood_donation/provider/user_provider.dart';
import 'package:blood_donation/widget/add_blood.dart';
import 'package:blood_donation/widget/profile.dart';
import 'package:blood_donation/widget/search.dart';
import 'package:blood_donation/widget/userFavorite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/navigation_provider.dart';
import '../widget/HomeContent.dart';
import '../widget/bottom_navigationbar_widget.dart';
import '../widget/navigation_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  UserProvider? userProvider;

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  final pageList = [
    const HomeContent(),
    const UserFavoritePage(),
    const SearchPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    if (userProvider?.userModel.isDonor == true)
      pageList[1] = const AddBloodPage();
    return Consumer<NavigationProvider>(
      builder: (context, value, child) => Scaffold(
        bottomNavigationBar: const BottomBarWidget(),
        drawer: const NavigationDrawerWidget(),
        body: pageList[value.currentIndex],
      ),
    );
  }
}
