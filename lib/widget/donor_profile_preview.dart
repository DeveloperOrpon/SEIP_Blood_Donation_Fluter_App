import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:blood_donation/model/blood_donate_post.dart';
import 'package:blood_donation/model/comment_model.dart';
import 'package:blood_donation/model/user_model.dart';
import 'package:blood_donation/provider/comment_provider.dart';
import 'package:blood_donation/provider/user_provider.dart';
import 'package:blood_donation/utils/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/favorite_model.dart';
import '../utils/style.dart';

class DonorProfilePreViewPage extends StatefulWidget {
  const DonorProfilePreViewPage({Key? key}) : super(key: key);
  static const String routeName = "/commentPage";

  @override
  State<DonorProfilePreViewPage> createState() =>
      _DonorProfilePreViewPageState();
}

class _DonorProfilePreViewPageState extends State<DonorProfilePreViewPage> {
  BloodDonatePostModel? post;
  UserModel? user;
  double rateDonor = 3.0;
  final commentController = TextEditingController();
  CommentProvider? commentProvider;
  Color bgColor = Colors.grey;

  @override
  void didChangeDependencies() {
    commentProvider = Provider.of<CommentProvider>(context, listen: false);
    post = ModalRoute.of(context)?.settings.arguments as BloodDonatePostModel;
    _getDonorInfo(post!.userId);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void _getDonorInfo(int userId) async {
    user = await Provider.of<UserProvider>(context, listen: false)
        .getUserByUserId(userId);
    print(user!.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post!.donorName),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) => ListView(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 260,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color(0xFFE74251),
                    Color(0xFFEB2033),
                  ])),
                  child: Column(
                    children: [
                      Hero(
                        tag: post!.userId,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(File(post!.donorImageUrl)),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        post!.donorName,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      FutureBuilder<UserModel?>(
                          future: provider.getUserByUserId(post!.userId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!.phone,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              );
                            }
                            if (snapshot.hasError) {
                              print(snapshot.error.toString());
                              return const Text('Failed to load favorite');
                            }
                            return const Text('Loading');
                          }),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBarIndicator(
                            rating: 2.75,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            "(10)",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          )
                        ],
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
                              "${post!.bloodGroup} Group",
                              style: const TextStyle(fontFamily: 'Schyler'),
                            )
                          ],
                        ),
                        Column(
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
                              "4 Donate",
                              style: TextStyle(fontFamily: 'Schyler'),
                            )
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .3,
                              alignment: Alignment.center,
                              height: 50,
                              child: Flexible(
                                child: Text(
                                  post!.postTime,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Schyler',
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const Text(
                              "Last Donation",
                              style: TextStyle(fontFamily: 'Schyler'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -70,
                  right: -70,
                  child: InkWell(
                    onTap: _addToFav,
                    /////////
                    child: FutureBuilder(
                      future: provider.didDonorIsFavorite(
                          provider.userModel.userId!, post!.userId),
                      builder: (context, snapshot) {
                        print("object");
                        if (snapshot.hasData) {
                          final data = snapshot.data;
                          return AvatarGlow(
                            glowColor: Colors.white,
                            endRadius: 120,
                            duration: Duration(milliseconds: 2000),
                            repeat: true,
                            showTwoGlows: true,
                            curve: Curves.easeOutQuad,
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(99)),
                              child: Icon(
                                Icons.favorite,
                                color: data! ? Colors.red : Colors.grey,
                                size: 40,
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return const Text('Failed to load favorite');
                        }
                        return const Text('Loading');
                      },
                    ),
                  ),
                ),
                Positioned(
                    top: -70,
                    left: -70,
                    child: InkWell(
                      onTap: _callDonor,
                      child: AvatarGlow(
                        glowColor: Colors.white,
                        endRadius: 120,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        curve: Curves.easeOutQuad,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(99)),
                          child: Icon(
                            Icons.phone,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 50),
                  child: Text(
                    "Comment and Review",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
                InkWell(
                  onTap: _showCommentBox,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 50, left: 20),
                    height: 40,
                    width: 120,
                    decoration: inputDecorationRed,
                    child: Text(
                      "Comment Here",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 6),
            Divider(height: 2),
            SizedBox(height: 6),
            FutureBuilder(
              future: commentProvider?.getComments(post!.userId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final comments = snapshot.data;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 450,
                    child: ListView.builder(
                      itemCount: comments!.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(comments[index].commenterName),
                        subtitle: Text(comments[index].comment),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text("${comments[index].rating}")
                          ],
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
              },
            )
          ],
        ),
      ),
    );
  }

  void _showCommentBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.red,
                blurRadius: 5.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            // To make the card compact
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Type Here Your Comment!!',
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.close, color: Colors.red)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CupertinoTextField(
                controller: commentController,
                maxLines: 3,
                prefix: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.comment_bank_outlined),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              Flexible(
                child: const Text(
                  "Rating Donor - :",
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    onRatingUpdate: (rating) {
                      rateDonor = rating;
                    },
                    initialRating: rateDonor,
                    minRating: 1,
                    allowHalfRating: true,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 30.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: CupertinoButton(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                    _commentPost();
                  },
                  child: const Text(
                    "Post Comment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _commentPost() async {
    print("ok");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final commentProvider =
        Provider.of<CommentProvider>(context, listen: false);
    String commentTime = DateFormat.yMEd().add_jms().format(DateTime.now());
    if (await commentProvider.didUserComment(
        userProvider.userModel.userId!, post!.userId)) {
      showErrorMsg("You Already Comment", context);
      return;
    }
    print(
        "donor id: ${post!.userId} commentId :${userProvider.userModel.userId!}");
    final commentModel = CommentModel(
      donorId: post!.userId,
      commenterId: userProvider.userModel.userId!,
      rating: rateDonor,
      commenterName:
          "${userProvider.userModel.firstName} ${userProvider.userModel.lastName}",
      donorName: post!.donorName,
      comment: commentController.text,
      commentTime: commentTime,
    );

    await commentProvider.addComment(commentModel).whenComplete(() {
      showCorrectMsg("Add Your Comment", context);
      debugPrint("Complete");
      setState(() {});
    });
  }

  void _addToFav() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final favModel = FavoriteModel(
      donorImage:post!.donorImageUrl ,
      userId: userProvider.userModel.userId!,
      donorId: post!.userId,
      donorName: post!.donorName,
      donorBloodGroup: post!.bloodGroup,
      lastDateOfDonate: post!.postTime,
    );
    if (await userProvider.didDonorIsFavorite(
        userProvider.userModel.userId!, post!.userId)) {
      showErrorMsg("You Already Favorite", context);
      return;
    }
    setState(() {
      bgColor = Colors.red;
    });
    await userProvider.addFavorite(favModel).whenComplete(() => {
          showCorrectMsg("Added To Favorite", context),
        });
  }

  void _callDonor() async {
    String telephoneUrl = "tel:${user!.phone}";
    if (await canLaunch(telephoneUrl)) {
      await launch(telephoneUrl);
    } else {
      throw "Error occured trying to call that number.";
    }
  }
}
