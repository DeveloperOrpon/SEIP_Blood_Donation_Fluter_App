import 'dart:io';

import 'package:blood_donation/provider/user_provider.dart';
import 'package:blood_donation/widget/donor_post_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../model/blood_donate_post.dart';
import '../model/favorite_model.dart';
import '../utils/style.dart';
import 'blood_drop_design.dart';
import 'donor_profile_preview.dart';

class UserFavoritePage extends StatefulWidget {
  const UserFavoritePage({super.key});

  static const String routeName = '/favorite';

  @override
  State<UserFavoritePage> createState() => _UserFavoritePageState();
}

class _UserFavoritePageState extends State<UserFavoritePage> {
  @override
  void initState() {
    EasyLoading.show(status: 'loading...');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) => ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            alignment: Alignment.center,
            height: 160,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE74251),
                  Color(0xFFEB2033),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Hi ${provider.userModel.lastName} !!!! Your Favorite Donor",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/ob1.png',
                      width: 150,
                      height: 60,
                      fit: BoxFit.fill,
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  height: 50,
                  width: MediaQuery.of(context).size.width * .6,
                  decoration: inputDecorationRed,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "Your Favorite Donars",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Schyler",
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          //showing favorite donors
          FutureBuilder(
            future: provider.getFavorite(provider.userModel.userId!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                EasyLoading.dismiss();
                final data = snapshot.data;
                return SizedBox(
                  height:MediaQuery.of(context).size.height- 300,
                  child: ListView.builder(
                    itemCount: data!.length,
                      itemBuilder: (context, index) => ShowFavWidget(index, data[index]),
                  ),
                );
              }
              if (snapshot.hasError) {
                EasyLoading.dismiss();
                print(snapshot.error.toString());
                return const Text("");
              }
              return  Text("");
            },
          )
        ],
      ),
    );
  }

  Widget ShowFavWidget (int index, FavoriteModel favoriteModel) {
    final _w = MediaQuery.of(context).size.width;
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: const Duration(milliseconds: 100),
      child: SlideAnimation(
        duration: const Duration(milliseconds: 2500),
        curve: Curves.fastLinearToSlowEaseIn,
        verticalOffset: 250,
        child: ScaleAnimation(
          duration: const Duration(milliseconds: 1500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: InkWell(
            onTap:() {
              _showProfileInfo(favoriteModel.donorId);
            },
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: _w / 20,right: 10,left: 10),
              height: _w / 3,
              decoration: inputDecorationRed,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding:
                    EdgeInsets.only(top: 8, bottom: 10, right: 10),
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                      FileImage(File(favoriteModel.donorImage)),
                    ),
                    title: Text(
                      favoriteModel.donorName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Schyler",
                      ),
                    ),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.location_fill,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            "address",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: "Schyler",
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Flexible(
                      child: BloodDropDesign(favoriteModel.donorBloodGroup),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 6),
                    child: Flexible(child: Text("last Donate : ${favoriteModel.lastDateOfDonate}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: "Schyler",
                      ),)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showProfileInfo(int userId) async {
    final provider =Provider.of<UserProvider>(context,listen: false);
    BloodDonatePostModel? model = await provider.getDonatePostByUserId(userId);
   Navigator.pushNamed(context, DonorProfilePreViewPage.routeName,arguments: model);
  }
}
