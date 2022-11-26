import 'dart:io';

import 'package:blood_donation/provider/user_provider.dart';
import 'package:blood_donation/utils/helper_function.dart';
import 'package:blood_donation/widget/donor_post_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/search_delegate.dart';
import '../utils/style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static const String routeName = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> bloodGroup = [
    'A-',
    'A+',
    'AB-',
    'AB+',
    'B-',
    'B+',
    'O-',
    'O+',
  ];
  List<String> locationList = [
    'Dhaka',
    'Mirpur',
    'Uttara',
    'Framgate',
    'Azimpur',
    'Banani',
    "Mohakhali",
    'Tajgon',
    "Badda"
  ];

  List<String> provinces = [];
  String? selectBloodGroup;
  String? selectLocation;
  String? _date;
  int index = 0;
  double expandedHeight = 100;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        expandedHeight = 100.0;
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        expandedHeight = 100.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.show(status: 'loading...');
    final width = MediaQuery.of(context).size.width;
    return Consumer<UserProvider>(
        builder: (context, userProvider, child) => CustomScrollView(
              controller: _controller,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: expandedHeight,
                  centerTitle: true,
                  bottom: expandedHeight == 300
                      ? PreferredSize(
                          preferredSize: Size.fromHeight(300),
                          child: Container(
                            height: 300,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 40, right: 40, top: 10, bottom: 10),
                                  child: const Text(
                                    "Filtering Blood Donation Post",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showSearch(
                                        context: context,
                                        delegate:
                                            SearchDelegateBlood(bloodGroup));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                    decoration: inputDecorationRed,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text(
                                          "Tap To Searching Blood Donor",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: "Schyler",
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          CupertinoIcons.location_solid,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                //BLOOD GROUP AND ADDRESS
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        selectBloodGroupUi(context, (value) {
                                          setState(() {
                                            index = 1;
                                            selectBloodGroup = value;
                                          });
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 150,
                                        height: 40,
                                        decoration: inputDecorationRed,
                                        child: Text(selectBloodGroup ??
                                            "Select-Blood-Group"),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                          selectAddressGroupUi(context,
                                              (value) {
                                            setState(() {
                                              selectLocation = value;
                                              index = 2;
                                            });
                                          });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 160,
                                        height: 40,
                                        decoration: inputDecorationRed,
                                        child: Text(selectLocation ??
                                            "Select-Address-City"),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: _datePick,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 120,
                                        height: 40,
                                        decoration: inputDecorationRed,
                                        child: Text("Select-Date"),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          index = 0;
                                          selectLocation = null;
                                          selectBloodGroup = null;
                                        });
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 120,
                                        height: 40,
                                        decoration: inputDecorationRed,
                                        child: const Text("Clear Filter"),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      : PreferredSize(
                          preferredSize: Size.fromHeight(40),
                          child: Container(
                            height: 30,
                            width: 150,
                            decoration: inputDecorationBlue,
                            child: const Center(
                              child: Text("Tap For Filtering"),
                            ),
                          ),
                        ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      "assets/images/demo.jpg",
                      fit: BoxFit.cover,
                    ),
                    title: InkWell(
                      onTap: () {
                        setState(() {
                          print(expandedHeight);
                          expandedHeight == 100
                              ? expandedHeight = 300
                              : expandedHeight = 100;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .35),
                        padding: const EdgeInsets.all(8),
                        height: 35,
                        decoration: inputDecorationBlue,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Flexible(
                              child: Text(
                                "Tap",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              FontAwesomeIcons.search,
                              color: Colors.blue,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 10),
                    FutureBuilder<List>(
                      future: index == 0
                          ? userProvider.findAllDonationPost()
                          : index == 1
                              ? userProvider
                                  .getPostByBloodGroup(selectBloodGroup!)
                              : userProvider.getPostByBloodGroupAndLocation(
                                  selectBloodGroup!, selectLocation!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          EasyLoading.dismiss();
                          final data = snapshot.data;
                          print("${data?.length}");
                          return Column(
                            children: data!
                                .map((e) =>
                                    AnimationConfiguration.staggeredList(
                                      position: 1,
                                      delay: const Duration(milliseconds: 100),
                                      child: SlideAnimation(
                                        duration:
                                            const Duration(milliseconds: 2500),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        verticalOffset: 250,
                                        child: ScaleAnimation(
                                          duration: const Duration(
                                              milliseconds: 1500),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(
                                                bottom: width / 20),
                                            height: width / 3,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Colors.white,
                                                Colors.grey.shade50
                                              ]),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 40,
                                                  spreadRadius: 10,
                                                ),
                                              ],
                                            ),
                                            child: DonorPostWidget(
                                              postModel: e,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Text("");
                        }
                        return const Text("");
                      },
                    ),
                  ]),
                )
              ],
            ));
  }

  void _uiRerander() {
    print("ok");
  }

  void _datePick() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      setState(() {
        _date = DateFormat("dd/MM/yyyy").format(selectedDate);
      });
    }
  }
}
// onTap: () {
//                                         Navigator.pushNamed(context, DonorProfilePreViewPage.routeName,arguments: e);
//                                       },
