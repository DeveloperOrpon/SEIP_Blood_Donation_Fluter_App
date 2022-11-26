
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../model/comment_model.dart';
import '../provider/user_provider.dart';
import '../widget/donate_post_widget.dart';

class DonorHistoryPage extends StatefulWidget {

  const DonorHistoryPage({Key? key}) : super(key: key);
  static const String routePage = '/history';

  @override
  State<DonorHistoryPage> createState() => _DonorHistoryPageState();
}

class _DonorHistoryPageState extends State<DonorHistoryPage> {
  late UserProvider userProvider;
  int _slidingValue = 0;
  List<CommentModel> comment=[];

  @override
  void didChangeDependencies() async {
    userProvider = ModalRoute.of(context)!.settings.arguments as UserProvider;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("${userProvider.bloodDonatePostModel!.donorName}");
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Your History",
          style: TextStyle(
            fontSize: 22,
            fontFamily: "Schyler",
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          _slidingValue==0?DonatePostWidget(bloodDonatePostModel: userProvider.bloodDonatePostModel!,)
          :FutureBuilder(

            future: userProvider.getComments(userProvider.userModel.userId!),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  final data=snapshot.data;
                 return Padding(
                   padding: EdgeInsets.only(top: 40),
                    child: ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
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
                                leading: FutureBuilder(
                                  future: userProvider.getUserByUserId(data[index].commenterId),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      final data=snapshot.data;
                                      return CircleAvatar(
                                        radius:40,
                                        backgroundImage: FileImage(File(data!.imageUrl)),
                                      );
                                    }
                                    if (snapshot.hasError) {
                                      print(snapshot.error.toString());
                                      return const Text('Failed to load favorite');
                                    }
                                    return const Text('Loading');
                                  },

                                ),
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data[index].donorName),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data[index].comment),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star,color: Colors.amberAccent,),
                                    SizedBox(width: 8),
                                    Text("${data[index].rating}")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return const Text('Failed to load favorite');
                }
                return const Text('Loading');

              },),
          Positioned(
            left: 10,
            top: 5,
            right: 10,
            child: CupertinoSlidingSegmentedControl(
              backgroundColor: Colors.white,
              thumbColor: Colors.red,
              groupValue: _slidingValue,
              children: {
                0: Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, right: 20, bottom: 10),
                  child: Text(
                    "POST",
                    style: TextStyle(
                        color: _slidingValue == 0 ? Colors.white : Colors.black,
                        fontSize: 18),
                  ),
                ),
                1: Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, right: 20, bottom: 10),
                  child: Text(
                    "Review",
                    style: TextStyle(
                        color: _slidingValue == 1 ? Colors.white : Colors.black,
                        fontSize: 18),
                  ),
                ),
              },
              onValueChanged: (value) {
                setState(() {
                  _setValue();
                  _slidingValue = value!;

                });
              },
            ),
          )
        ],
      ),
    );
  }

  void _setValue () async{
    comment=await userProvider.getComments(userProvider.userModel.userId!);
  }
}
