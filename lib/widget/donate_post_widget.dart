import 'dart:io';

import 'package:blood_donation/model/blood_donate_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'blood_drop_design.dart';

class DonatePostWidget extends StatelessWidget {
  final BloodDonatePostModel bloodDonatePostModel;
  const DonatePostWidget({Key? key, required this.bloodDonatePostModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return AnimationLimiter(
      child: ListView.builder(
        padding:
        EdgeInsets.only(left: _w / 20, right: _w / 20, top: _w / 7),
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: Duration(milliseconds: 100),
            child: SlideAnimation(
              duration: Duration(milliseconds: 2500),
              curve: Curves.fastLinearToSlowEaseIn,
              verticalOffset: -250,
              child: ScaleAnimation(
                duration: Duration(milliseconds: 1500),
                curve: Curves.fastLinearToSlowEaseIn,
                child: Container(
                  alignment: Alignment.centerLeft,

                  margin: EdgeInsets.only(bottom: _w / 20),
                  height: _w / 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius:40,
                      backgroundImage: FileImage(File(bloodDonatePostModel.donorImageUrl)),
                    ),
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bloodDonatePostModel.donorName),
                        Text(bloodDonatePostModel.isActive?"Active":"InActive"),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bloodDonatePostModel.city),
                        Text(bloodDonatePostModel.state),
                      ],
                    ),
                    trailing: BloodDropDesign(bloodDonatePostModel.bloodGroup),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
