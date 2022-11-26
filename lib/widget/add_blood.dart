import 'package:blood_donation/model/blood_donate_post.dart';
import 'package:blood_donation/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utils/helper_function.dart';
import '../utils/style.dart';
import 'blood_drop_design.dart';

class AddBloodPage extends StatefulWidget {
  const AddBloodPage({super.key});

  @override
  State<AddBloodPage> createState() => _AddBloodPageState();
}

class _AddBloodPageState extends State<AddBloodPage> {
  String? selectedBloodGroup;
  String stateValue = "Dhaka";
  String? cityValue;
  String? countryValue;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) => ListView(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Post For Blood Donate",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: "Schyler",
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 50,
            width: MediaQuery.of(context).size.width * .6,
            decoration: inputDecorationRed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  selectedBloodGroup ?? "Select Your Location or Address",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontFamily: "Schyler",
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
            decoration: inputDecorationRed,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _selectDivision,
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      decoration: inputDecoration,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            stateValue??
                            "Select Division",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Schyler",
                              color: Colors.grey,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down_outlined,
                              color: Colors.grey)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.green,
                    onTap: () {
                      selectAddressGroupUi(context, (value){
                        setState(() {
                          cityValue=value;
                        });
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      decoration: inputDecoration,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                             cityValue??
                            "Select City",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Schyler",
                              color: Colors.grey,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down_outlined,
                              color: Colors.grey)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const Text(
                  "Select Blood Group",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Schyler",
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    BloodDropDesign("A+"),
                    BloodDropDesign("B+"),
                    BloodDropDesign("AB+"),
                    BloodDropDesign("O+"),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    BloodDropDesign("A-"),
                    BloodDropDesign("B-"),
                    BloodDropDesign("AB-"),
                    BloodDropDesign("O-"),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: CupertinoButton(
              color: Colors.red,
              child: const Text(
                "POST",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Schyler",
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _createPost(provider);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _createPost(UserProvider provider) async {
    bool havePost = await provider.didDonorPost(provider.userModel.userId!);
    if (provider.selectBlood == ''|| cityValue == null) {
      showCorrectMsg("Please Fill All the Field", context);
      return;
    }
    if (havePost) {
      showCorrectMsg("You All ready Have a Post. First Delete It", context);
      print(
          "has data, ${havePost.toString()} id- : ${provider.userModel.userId!}");
      return;
    }

    String formattedDate = DateFormat.yMEd().add_jms().format(DateTime.now());
    final post = BloodDonatePostModel(
      donorImageUrl: provider.userModel.imageUrl,
      userId: provider.userModel.userId!,
      donorName: provider.userModel.firstName + provider.userModel.lastName,
      bloodGroup: provider.selectBlood,
      state: stateValue,
      city: cityValue!,
      postTime: formattedDate,
      isActive: true,
    );
    int id = await provider.insertDonorPost(post);
    if (await provider.getDonatePostByUserId(provider.userModel.userId!) != null) {
      provider.bloodDonatePostModel =
          (await provider.getDonatePostByUserId(provider.userModel.userId!))!;
    }
    showCorrectMsg("Your Blood Donation Post All ready Live!!!", context);
    provider.selectBlood = '';
    cityValue = '';
    stateValue = '';
  }

  void _selectDivision() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
              onPressed: () {
                stateValue = "Dhaka";
                Navigator.pop(context);
                setState(() {});
              },
              child: const Text("Dhaka")),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
      ),
    );
  }
}
