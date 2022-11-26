import 'package:blood_donation/pages/LauncherPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../data/demo_question.dart';
import '../provider/user_provider.dart';
import '../utils/helper_function.dart';
import 'home_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  static const String routeName = '/';
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController pageController;

  @override
  void initState() {
    EasyLoading.show(status: 'loading...');
    redirectUser();
    pageController = PageController();
    super.initState();
  }
  redirectUser() async {
    if (await getLoginStatus()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final id = await getUserId();
      userProvider.userModel = (await userProvider.getUserByUserId(id))!;
      if (await userProvider.getDonatePostByUserId(id) != null) {
        userProvider.bloodDonatePostModel =
        (await userProvider.getDonatePostByUserId(id))!;
      }
      userProvider.getAllDonationPost();
      Navigator.pushReplacementNamed(context, HomePage.routeName);
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }

  int currentPage = 0;
  List colors = const [
    Color.fromARGB(255, 239, 203, 186),
    Color(0xffFFE5DE),
    Color(0xffc3e2cf),
  ];

  AnimatedContainer pageIndicator({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Colors.red,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeInOut,
      width: currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return  Scaffold(

      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (value) => setState(() => currentPage = value),
                itemCount: onboardingContents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            onboardingContents[i].image,
                            height: (height / 60) * 25,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          onboardingContents[i].title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontFamily: "Schyler",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          onboardingContents[i].desc,
                          style: const TextStyle(
                            fontFamily: "Schyler",
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            _indicator(width),
          ],
        ),
      ),
    );
  }

  Expanded _indicator(double width) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingContents.length,
              (int index) => pageIndicator(
                index: index,
              ),
            ),
          ),
          currentPage + 1 == onboardingContents.length
              ? Padding(
                  padding: const EdgeInsets.all(30),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LauncherPage.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: (width <= 550)
                          ? const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 20)
                          : EdgeInsets.symmetric(
                              horizontal: width * 0.2, vertical: 25),
                      textStyle: TextStyle(fontSize: (width <= 550) ? 13 : 17),
                    ),
                    child: const Text(
                      "START",
                      style: TextStyle(
                        fontFamily: "Schyler",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          pageController.jumpToPage(2);
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: (width <= 550) ? 13 : 17,
                          ),
                          padding: (width <= 550)
                              ? const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20)
                              : const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 25),
                        ),
                        child: const Text(
                          "SKIP",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Schyler",
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          padding: (width <= 550)
                              ? const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20)
                              : const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 25),
                          textStyle:
                              TextStyle(fontSize: (width <= 550) ? 13 : 17),
                        ),
                        child: const Text(
                          "NEXT",
                          style: TextStyle(
                            fontFamily: "Schyler",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
