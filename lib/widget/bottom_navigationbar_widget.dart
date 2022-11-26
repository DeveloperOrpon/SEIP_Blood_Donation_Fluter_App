import 'package:blood_donation/provider/navigation_provider.dart';
import 'package:blood_donation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  late UserProvider userProvider;
  @override
  void didChangeDependencies() {
    userProvider=Provider.of<UserProvider>(context,listen: false);
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    List<IconData> listOfNavigationIcons = [
      Icons.home_rounded,
      Provider.of<UserProvider>(context,listen: false).userModel.isDonor? Icons.add:Icons.favorite_rounded,
      FontAwesomeIcons.magnifyingGlass,
      Icons.person_rounded,
    ];
    Size size = MediaQuery.of(context).size;
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) => Container(
        margin: const EdgeInsets.all(20),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(.3),
              blurRadius: 30,
              offset: const Offset(5, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              provider.currentIndex = index;
              debugPrint("Is donner${userProvider.userModel.isDonor}");
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom:
                        index == provider.currentIndex ? 0 : size.width * .029,
                    right: size.width * .0422,
                    left: size.width * .0422,
                  ),
                  width: size.width * .128,
                  height:
                      index == provider.currentIndex ? size.width * .014 : 0,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                Icon(
                 listOfNavigationIcons[index],
                  size: size.width * .076,
                  color: index == provider.currentIndex
                      ? Colors.red
                      : Colors.black38,
                ),
                SizedBox(height: size.width * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
