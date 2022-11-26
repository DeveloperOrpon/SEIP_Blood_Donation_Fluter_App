import 'dart:io';

import 'package:blood_donation/model/blood_donate_post.dart';
import 'package:blood_donation/utils/style.dart';
import 'package:blood_donation/widget/blood_drop_design.dart';
import 'package:flutter/material.dart';

import 'donor_profile_preview.dart';

class DonorPostWidget extends StatelessWidget {
  final BloodDonatePostModel postModel;

  const DonorPostWidget({Key? key, required this.postModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DonorProfilePreViewPage.routeName,arguments: postModel);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: FileImage(File(postModel.donorImageUrl)),
              ),
              title: Text(postModel.donorName),
              subtitle:Text("${postModel.city},${postModel.state}"),
              trailing: BloodDropDesign(postModel.bloodGroup),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(postModel.postTime),
            )
          ],
        ),
      ),
    );
  }
}
