import 'dart:io';
import 'package:blood_donation/model/blood_donate_post.dart';
import 'package:blood_donation/provider/navigation_provider.dart';
import 'package:blood_donation/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../pages/donar_history_page.dart';
import '../utils/const.dart';
import '../utils/helper_function.dart';
import 'edit_address.dart';

class DonorProfile extends StatefulWidget {
  final UserProvider userProvider;

  const DonorProfile({Key? key, required this.userProvider}) : super(key: key);

  @override
  State<DonorProfile> createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFFE74251),
                Color(0xFFEB2033),
              ])),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => EditAddress(
                          userModel: widget.userProvider.userModel,
                          onUpdateComplite: () {
                            setState(() {});
                          },
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width,
                      child: const Icon(
                        FontAwesomeIcons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        FileImage(File(widget.userProvider.userModel.imageUrl)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.userProvider.userModel.firstName +
                        widget.userProvider.userModel.lastName,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.userProvider.userModel.phone,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  widget.userProvider.userModel.isDonor
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder<Map<String, dynamic>>(
                              future: widget.userProvider.getAvgOfDonorRating(
                                  widget.userProvider.userModel.userId!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final map = snapshot.data;
                                  return RatingBarIndicator(
                                    rating: map![avgRating] ?? 0.0,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  );
                                }
                                if (snapshot.hasError) {
                                  return const Text('Error loading');
                                }
                                return const Text('Loading');
                              },
                            ),
                            const SizedBox(width: 6),
                            FutureBuilder(
                              future: widget.userProvider.getComments(
                                  widget.userProvider.userModel.userId!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "(${snapshot.data!.length})",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return const Text('Error loading');
                                }
                                return const Text('Loading');
                              },
                            )
                          ],
                        )
                      : Text(
                          widget.userProvider.userModel.dateOfBirth,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              bottom: -50,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/bloodIcon.png",
                          width: 50,
                          height: 50,
                        ),
                        Text(
                          "${widget.userProvider.userModel.bloodGroup} Group",
                          style: const TextStyle(fontFamily: 'Schyler'),
                        )
                      ],
                    ),
                    widget.userProvider.userModel.isDonor
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              CircleAvatar(
                                backgroundColor: Color(0xFFE74251),
                                radius: 25,
                                child: Icon(
                                  Icons.personal_injury,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              Text(
                                "4 life Save",
                                style: TextStyle(fontFamily: 'Schyler'),
                              )
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xFFE74251),
                                radius: 25,
                                child: Icon(
                                  Icons.personal_injury,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              Text(
                                widget.userProvider.userModel.gender,
                                style: TextStyle(fontFamily: 'Schyler'),
                              ),
                            ],
                          ),
                    widget.userProvider.userModel.isDonor
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * .3,
                                alignment: Alignment.center,
                                height: 50,
                                child: Text(
                                  widget.userProvider.bloodDonatePostModel ==
                                          null
                                      ? "Not"
                                      : "${widget.userProvider.bloodDonatePostModel?.postTime}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Schyler',
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Text(
                                "Donation Post",
                                style: TextStyle(fontFamily: 'Schyler'),
                              )
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.userProvider.userModel.address,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Schyler',
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Text(
                                "Location",
                                style: TextStyle(fontFamily: 'Schyler'),
                              )
                            ],
                          )
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, top: 60, right: 15),
          child: Column(
            children: [
              if (widget.userProvider.userModel.isDonor)
                ListTile(
                  title: const Text(
                    "Available To Donate",
                    style: TextStyle(fontFamily: 'Schyler'),
                  ),
                  leading: const Icon(CupertinoIcons.calendar_today,
                      color: Colors.red),
                  trailing: CupertinoSwitch(
                    activeColor: Colors.red,
                    value: widget.userProvider.bloodDonatePostModel == null
                        ? false
                        : widget.userProvider.bloodDonatePostModel!.isActive,
                    onChanged: (value) {
                      setState(() {
                        _deactiveUser(value);
                        widget.userProvider.activeDonate = value;
                      });
                    },
                  ),
                ),
              Divider(
                height: .5,
                color: Colors.grey.shade300,
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => EditAddress(
                      userModel: widget.userProvider.userModel,
                      onUpdateComplite: () {
                        setState(() {});
                      },
                    ),
                  );
                },
                title: const Text(
                  "Manage Address",
                  style: TextStyle(fontFamily: 'Schyler'),
                ),
                leading:
                    const Icon(CupertinoIcons.location_fill, color: Colors.red),
                trailing: const Icon(Icons.arrow_forward_ios_rounded,
                    color: Colors.grey),
              ),
              Divider(
                height: .5,
                color: Colors.grey.shade300,
              ),
              if (widget.userProvider.userModel.isDonor)
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, DonorHistoryPage.routePage,
                        arguments: widget.userProvider);
                  },
                  title: Text(
                    "History",
                    style: TextStyle(fontFamily: 'Schyler'),
                  ),
                  leading: Icon(Icons.history, color: Colors.red),
                  trailing:
                      Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
                ),
              Divider(
                height: .5,
                color: Colors.grey.shade300,
              ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => EditAddress(
                      userModel: widget.userProvider.userModel,
                      onUpdateComplite: () {
                        setState(() {});
                      },
                    ),
                  );
                },
                title: Text(
                  "Change Password",
                  style: TextStyle(fontFamily: 'Schyler'),
                ),
                leading: Icon(Icons.lock, color: Colors.red),
                trailing:
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
              ),
              Divider(
                height: .5,
                color: Colors.grey.shade300,
              ),
              if (widget.userProvider.userModel.isDonor)
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, DonorHistoryPage.routePage,
                        arguments: widget.userProvider);
                  },
                  title: Text(
                    "Show Review",
                    style: TextStyle(fontFamily: 'Schyler'),
                  ),
                  leading: Icon(Icons.star, color: Colors.red),
                  trailing:
                      Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
                ),
              if (!widget.userProvider.userModel.isDonor)
                ListTile(
                  onTap: () {
                    Provider.of<NavigationProvider>(context, listen: false)
                        .currentIndex = 1;
                  },
                  title: const Text(
                    "Favorite",
                    style: TextStyle(fontFamily: 'Schyler'),
                  ),
                  leading: Icon(Icons.star, color: Colors.red),
                  trailing:
                      Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
                ),
              Divider(
                height: .5,
                color: Colors.grey.shade300,
              )
            ],
          ),
        )
      ],
    );
  }

  void _deactiveUser(bool value) async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    final bloodDonatePostModel = provider.bloodDonatePostModel;
    if (bloodDonatePostModel != null) {
      final post = BloodDonatePostModel(
        donorImageUrl: bloodDonatePostModel.donorImageUrl,
        userId: bloodDonatePostModel.userId,
        donorName: bloodDonatePostModel.donorName,
        bloodGroup: bloodDonatePostModel.bloodGroup,
        state: bloodDonatePostModel.state,
        city: bloodDonatePostModel.city,
        postTime: bloodDonatePostModel.postTime,
        isActive: value,
      );
      await provider.updateDonarPost(post);
      showCorrectMsg(value ? "You Are Online" : "You Are OffLine", context);
      provider.bloodDonatePostModel = await provider
          .getDonatePostByUserId(bloodDonatePostModel.userId)
          .whenComplete(() {
        setState(() {});
      });
    }
  }
}
