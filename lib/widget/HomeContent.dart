import 'dart:io';
import 'package:blood_donation/model/blood_donate_post.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/navigation_provider.dart';
import '../provider/user_provider.dart';
import '../utils/style.dart';
import 'blood_drop_design.dart';
import 'donor_profile_preview.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List sliderImage=[
    "assets/images/best_cover.jpg",
    "assets/images/best_cover.jpg",
    "assets/images/best_cover.jpg",
  ];
  late UserProvider userProvider;

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getAllDonationPost();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.show(status: 'loading...');
    final width = MediaQuery.of(context).size.width;
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) => CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            floating: true,
            pinned: false,
            snap: true,
            title: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 20, right: 20),
              height: 50,
              width: MediaQuery.of(context).size.width * .6,
              decoration: inputDecorationBlue,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Hi ${userProvider.userModel.lastName}",
                    style: smallAndGreyText,
                  ),
                  Container(
                    width: 2,
                    color: Colors.grey,
                  ),
                  StreamBuilder(
                      stream: Stream.periodic(const Duration(seconds: 1)),
                      builder: (context, snapshot) {
                        return Text(
                          DateFormat('hh:mm:ss').format(DateTime.now()),
                          style: smallAndGreyText,
                        );
                      }),
                  const Icon(
                    CupertinoIcons.clock,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            expandedHeight: 200,
            leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                FontAwesomeIcons.bars,
                color: Colors.blue,
                size: 32,
                shadows: [redShadow],
              ),
            ),
            flexibleSpace: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40)
              ),
              child: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.pin,
                  title: InkWell(
                    onTap: () {
                      final provider=Provider.of<NavigationProvider>(context,listen: false);
                      provider.currentIndex=2;
                    },
                    child: Container(
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
                  ), //Text
                  background: CarouselSlider(
                    options: CarouselOptions(
                      height: 230,
                      autoPlay: true,
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                    ),
                    items: sliderImage
                        .map((e) => Image.asset(
                      e,
                      fit: BoxFit.cover,
                    ))
                        .toList(),
                  ), //Images.network
                  ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 10),
              FutureBuilder<List>(
                future: userProvider.findAllDonationPost(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    EasyLoading.dismiss();
                    final data = snapshot.data;
                    print("${data?.length}");
                    return Column(
                      children: data!.map((e) => AnimationConfiguration.staggeredList(
                        position: 1,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          verticalOffset: 250,
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 1500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Container(
                              alignment: Alignment.centerLeft,

                              margin: EdgeInsets.only(bottom: width / 20),
                              height: width / 4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [Colors.white,Colors.grey.shade50]),
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, DonorProfilePreViewPage.routeName,arguments: e);
                                },
                                leading: Hero(
                                  tag:e.userId,
                                  child: CircleAvatar(
                                    radius:40,
                                    backgroundImage: FileImage(File(e.donorImageUrl)),
                                  ),
                                ),
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e.donorName),
                                    const SizedBox(width: 5,),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor:e.isActive?Colors.green:Colors.red ,
                                    )
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e.city),
                                    Text(e.state),
                                  ],
                                ),
                                trailing: BloodDropDesign(e.bloodGroup),
                              ),
                            ),
                          ),
                        ),
                      )).toList(),
                     );
                  }
                  if (snapshot.hasError) {
                    return const Text("");
                  }
                  return const Text("");
                },
              ),
              const SizedBox(height: 500,)
            ]),
          )
        ],
      ),
    );
  }
}
