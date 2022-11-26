import 'dart:io';
import 'package:blood_donation/model/user_model.dart';
import 'package:blood_donation/pages/LauncherPage.dart';
import 'package:blood_donation/provider/user_provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:blood_donation/data/demo_question.dart';
import 'package:blood_donation/utils/helper_function.dart';
import 'package:blood_donation/widget/donor_faq.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:blood_donation/pages/Login_page.dart';
import 'package:provider/provider.dart';
import '../utils/style.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  static const String routeName = '/signup';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  List<String> suggestonsLocation = [
    "Mirpur",
    "Mohakhali",
    "Uttara",
    "Banani",
    "Khilkhet",
    "Azimpur",
    "Framgate"
  ];
  UserProvider? userProvider;
  String? msgError;
  String? emailError;
  String? passwordError;
  bool checkBoxClick = false;
  String? _date;
  String? imageUrl;
  bool isCheckTerms = false;
  bool isDonor = false;
  String? selectedAddress;
  String? selectedBloodGroup;
  String? selectedGender;
  bool _onEditing = true;
  bool confirmStage = false;
  bool stage1 = true;
  bool stage2 = false;
  bool stage3 = false;
  bool infoStage = false;
  bool isChecked = false;
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;
  final _formKey = GlobalKey<FormState>();
  final passwordControllar = TextEditingController();
  final emailControllar = TextEditingController();
  final confirmPasswordControllar = TextEditingController();
  final firstNameControllar = TextEditingController();
  final lastNameControllar = TextEditingController();
  final nidControllar = TextEditingController();
  final phoneControllar = TextEditingController();

  @override
  void dispose() {
    emailControllar.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _header(context),
          if (stage1) _stageOne(context),
          if (confirmStage) _confirmStage(context),
          if (!stage1 && stage2 && !infoStage && !stage3) _stageTwo(context),
          if (infoStage) _takeDonorInfo(context),
          if (stage3) _reviewInfo(context),
        ],
      ),
    );
  }

  Container _reviewInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Review And Confirm",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Schyler",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          const Text(
            'We will verify the information you have e'
            'ntered can access the application',
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Schyler",
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Card(
              elevation: 10.0,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 30, top: 15, right: 60, bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(child: Text('Full Name')),
                            Expanded(
                                child: Text(
                                    "${firstNameControllar.text} ${lastNameControllar.text}")),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Expanded(child: Text('Mobile Number')),
                            Expanded(child: Text(phoneControllar.text)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(child: Text('Date of Birth')),
                            Expanded(child: Text(_date!)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Expanded(child: Text('Address')),
                            Expanded(child: Text(selectedAddress!)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            const Expanded(child: Text('Gender')),
                            Expanded(child: Text(selectedGender!)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            const Expanded(child: Text('Blood Group')),
                            Expanded(child: Text(selectedBloodGroup!)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            const Expanded(child: Text('NID Number')),
                            Expanded(child: Text(nidControllar.text)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    margin: const EdgeInsets.all(15),
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                      color: Colors.grey.shade200,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 2.0,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.file(
                        File(imageUrl!),
                        height: 200,
                        width: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      GFCheckbox(
                        size: 25,
                        activeBgColor: Colors.red,
                        inactiveBorderColor: Colors.transparent,
                        inactiveBgColor: Colors.grey.shade300,
                        onChanged: (value) {
                          setState(() {
                            checkBoxClick = value;
                          });
                        },
                        value: checkBoxClick,
                      ),
                      const Flexible(
                        child: Text(
                          'We will verify the information you have e'
                          'ntered can access the application',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Schyler",
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  CupertinoButton(
                    child: const Text(
                      "CREATE",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _saveDataInDataBase,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 14),
                ],
              ))
          // CupertinoButton(
          //   child: Text("Click"),
          //   onPressed: () {
          //     debugPrint(
          //       "First NAME: ${firstNameControllar.text}"
          //           "last Name : ${lastNameControllar.text}"
          //           "email Name : ${emailControllar.text}"
          //           "email Name : ${passwordControllar.text}"
          //           "email Name : ${nidControllar.text}"
          //           "email Name : ${phoneControllar.text}"
          //           "email Name : ${imageUrl}"
          //           "email Name : ${selectedGender}"
          //           "email Name : ${selectedAddress}"
          //           "email Name : ${selectedBloodGroup}"
          //           "email Name : ${_date}"
          //     );
          //   },
          // )
        ],
      ),
    );
  }

  Container _takeDonorInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Questionnaires",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Schyler",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Fill up following questions and become a donor",
            style: TextStyle(
              color: Colors.grey,
              fontFamily: "Schyler",
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: question.length,
              itemBuilder: (context, index) =>
                  DonarFAQWidget(question: question[index]),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                GFCheckbox(
                  size: 25,
                  activeBgColor: Colors.red,
                  inactiveBorderColor: Colors.transparent,
                  inactiveBgColor: Colors.grey.shade300,
                  onChanged: (value) {
                    setState(() {
                      isCheckTerms = value;
                    });
                  },
                  value: isCheckTerms,
                ),
                const Flexible(
                  child: Text(
                    "By clicking,you agree to our terms and conditions",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Schyler",
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: CupertinoButton(
              color: Colors.red,
              onPressed: () {
                setState(() {
                  infoStage = false;
                  stage3 = true;
                });
              },
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }

  Container _stageTwo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (msgError != null)
            Text(
              msgError!,
              style: const TextStyle(color: Colors.redAccent),
            ),
          InkWell(
            onTap: () {
              showCustomAlertDialog(
                context,
                "Camera",
                "Gallery",
                "Choose Your Source",
                (String value) {
                  setState(
                    () {
                      imageUrl = value;
                    },
                  );
                },
              );
            },
            child: imageUrl == null
                ? Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: .5,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: const Icon(
                      CupertinoIcons.camera,
                      color: Colors.grey,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("$imageUrl"),
                      radius: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.file(
                          File(imageUrl!),
                          fit: BoxFit.cover,
                          width: 120,
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    decoration: inputDecoration,
                    child: CupertinoTextField(
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      style: const TextStyle(color: Colors.grey),
                      placeholder: "First Name",
                      placeholderStyle: const TextStyle(
                        color: Colors.grey,
                        fontFamily: "Schyler",
                        fontSize: 14,
                      ),
                      controller: firstNameControllar,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    decoration: inputDecoration,
                    child: CupertinoTextField(
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      style: const TextStyle(color: Colors.grey),
                      placeholder: "Last Name",
                      placeholderStyle: const TextStyle(
                        color: Colors.grey,
                        fontFamily: "Schyler",
                        fontSize: 14,
                      ),
                      controller: lastNameControllar,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                decoration: inputDecoration,
                child: CupertinoTextField(
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  style: const TextStyle(color: Colors.grey),
                  placeholder: "NID Number",
                  placeholderStyle: const TextStyle(
                    color: Colors.grey,
                    fontFamily: "Schyler",
                    fontSize: 14,
                  ),
                  controller: nidControllar,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                decoration: inputDecoration,
                child: CupertinoTextField(
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  style: const TextStyle(color: Colors.grey),
                  placeholder: "Phone Number",
                  placeholderStyle: const TextStyle(
                    color: Colors.grey,
                    fontFamily: "Schyler",
                    fontSize: 14,
                  ),
                  controller: phoneControllar,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: _selectGender,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 10, right: 12),
                  height: 50,
                  width: MediaQuery.of(context).size.width * .36,
                  decoration: inputDecoration,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        selectedGender ?? "Select Gender",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Schyler",
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        CupertinoIcons.person_2_alt,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: _datePick,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 10, right: 12),
                  height: 50,
                  width: MediaQuery.of(context).size.width * .36,
                  decoration: inputDecoration,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _date ?? "Date Of Birth",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Schyler",
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.calendar_month,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Flexible(
            child: InkWell(
              onTap: () {
                selectBloodGroupUi(context, (value) {
                  setState(() {
                    selectedBloodGroup = value;
                  });
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(top: 10, right: 12),
                height: 50,
                width: MediaQuery.of(context).size.width * .6,
                decoration: inputDecoration,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedBloodGroup ?? "Select Your Blood Group",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Schyler",
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.bloodtype,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          //autoComplite Location
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Flexible(
              child: InkWell(
                onTap: () {
                  selectAddressGroupUi(context, (value) {
                    setState(() {
                      selectedAddress = value;
                    });
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 10, right: 12),
                  height: 50,
                  width: MediaQuery.of(context).size.width * .6,
                  decoration: inputDecoration,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        selectedAddress ?? "Select Your Address",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Schyler",
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.bloodtype,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              GFCheckbox(
                size: 25,
                activeBgColor: Colors.red,
                inactiveBorderColor: Colors.transparent,
                inactiveBgColor: Colors.grey.shade300,
                onChanged: (value) {
                  setState(() {
                    isDonor = value;
                  });
                },
                value: isDonor,
              ),
              const Flexible(
                child: Text(
                  "Sign up as donor",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Schyler",
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          CupertinoButton(
            color: Colors.red,
            child: const Text(
              "Continue",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Schyler",
              ),
            ),
            onPressed: () {
              setState(() {});
              if (firstNameControllar.text.isEmpty ||
                  lastNameControllar.text.isEmpty ||
                  nidControllar.text.isEmpty ||
                  phoneControllar.text.isEmpty ||
                  _date == null ||
                  selectedBloodGroup == null ||
                  selectedGender == null ||
                  selectedAddress == null ||
                  imageUrl == null) {
                msgError = "Please Input All Field";
                return;
              } else {
                msgError = null;
                if (isDonor) {
                  infoStage = true;
                } else {
                  stage3 = true;
                }
              }
            },
          )
        ],
      ),
    );
  }

  Container _confirmStage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      height: MediaQuery.of(context).size.height - 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(FontAwesomeIcons.circleCheck),
              SizedBox(
                width: 4,
              ),
              Text(
                "Verification Code",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Schyler",
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "We will send you a verification code on your email address",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Schyler",
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 15),
          VerificationCode(
            fullBorder: true,
            textStyle: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Theme.of(context).primaryColor),
            keyboardType: TextInputType.number,
            underlineColor: Colors.red,
            // If this is null it will use primaryColor: Colors.red from Theme
            length: 4,
            cursorColor: Colors.red,
            margin: const EdgeInsets.all(12),
            onCompleted: (String value) {
              setState(() {});
            },
            onEditing: (bool value) {
              setState(() {
                _onEditing = value;
              });
              if (!_onEditing) FocusScope.of(context).unfocus();
            },
          ),
          const SizedBox(height: 15),
          const Text(
            "Didn't recived code?",
            style: TextStyle(
              color: Colors.grey,
              fontFamily: "Schyler",
              fontSize: 12,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Resend OTP",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Schyler",
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          CupertinoButton(
            color: Colors.red,
            child: const Text(
              "Continue",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              setState(() {
                stage2 = true;
                confirmStage = false;
              });
            },
          )
        ],
      ),
    );
  }

  Container _stageOne(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 40,
      ),
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Create your account",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Schyler",
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'Please enter your information to create account',
            style: TextStyle(
              color: Colors.grey,
              fontFamily: "Schyler",
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 40),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  elevation: 2,
                  child: CupertinoTextField(
                    clearButtonMode: OverlayVisibilityMode.always,
                    style: const TextStyle(color: Colors.grey),
                    placeholder: "Email Address",
                    placeholderStyle: const TextStyle(
                      color: Colors.grey,
                      fontFamily: "Schyler",
                      fontSize: 14,
                    ),
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                      left: 10,
                    ),
                    controller: emailControllar,
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 5),
                      child: Icon(
                        CupertinoIcons.mail_solid,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                if (emailError != null)
                  Text(
                    emailError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                Card(
                  elevation: 2,
                  child: CupertinoTextField(
                    keyboardType: TextInputType.text,
                    obscureText: !_passwordVisible,
                    style: const TextStyle(color: Colors.grey),
                    placeholder: "Password",
                    placeholderStyle: const TextStyle(
                      color: Colors.grey,
                      fontFamily: "Schyler",
                      fontSize: 14,
                    ),
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                      left: 10,
                    ),
                    controller: passwordControllar,
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 5),
                      child: Icon(
                        CupertinoIcons.lock,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                    suffix: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                if (passwordError != null)
                  Text(
                    passwordError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                Card(
                  elevation: 2,
                  child: CupertinoTextField(
                    keyboardType: TextInputType.text,
                    obscureText: !_passwordVisible2,
                    style: const TextStyle(color: Colors.grey),
                    placeholder: "Confirm Password",
                    placeholderStyle: const TextStyle(
                      color: Colors.grey,
                      fontFamily: "Schyler",
                      fontSize: 14,
                    ),
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                      left: 10,
                    ),
                    controller: confirmPasswordControllar,
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 5),
                      child: Icon(
                        CupertinoIcons.lock,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                    suffix: IconButton(
                      icon: Icon(
                        _passwordVisible2
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible2 = !_passwordVisible2;
                        });
                      },
                    ),
                  ),
                ),
                if (passwordError != null)
                  Text(
                    passwordError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    GFCheckbox(
                      size: 25,
                      activeBgColor: Colors.red,
                      inactiveBorderColor: Colors.transparent,
                      inactiveBgColor: Colors.grey.shade300,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value;
                        });
                      },
                      value: isChecked,
                    ),
                    Flexible(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontFamily: 'Schyler',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    'Creating an account your stay with our  '),
                            TextSpan(
                              text: 'terms of services and privacy policy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: _emailPassValitation,
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 20, right: 10),
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        decoration: BoxDecoration(
                          color:  Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "CREATE ACCOUNT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: "Schyler",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: "Schyler",
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, LoginPage.routeName);
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: "Schyler",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF17279),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.google,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(right: 15, left: 15),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF17279),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.facebookF,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF17279),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.twitter,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _header(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: const BoxDecoration(
              color: Color(0xFFF17279),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: const Text(
            "Register",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Schyler",
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF17279),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: stage2 ? const Color(0xFFF17279) : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: stage3 ? const Color(0xFFF17279) : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
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

  void _emailPassValitation() async {
    EasyLoading.show(status: 'loading...');
    setState(() {});
    if (emailControllar.text.isEmpty) {
      emailError = "Please Input Valid Email";
      EasyLoading.dismiss();
      return;
    }
    if (passwordControllar.text.isEmpty ||
        passwordControllar.text != confirmPasswordControllar.text) {
      passwordError = "Please Input Valid Password";
      emailError = '';
      EasyLoading.dismiss();
      return;
    }
    final user = await userProvider?.getUserByEmail(emailControllar.text);
    if (user != null) {
      EasyLoading.dismiss();
      //already have user
      print("Have Account");
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text(
            'Alert',
            style: TextStyle(
              color: Colors.red,
              fontFamily: "Schyler",
              fontSize: 22,
            ),
          ),
          content: Text(
            "You Have Already Account",
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "Schyler",
              fontSize: 20,
            ),
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              },
              child: Text("Login"),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () async {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, RegistrationPage.routeName);
              },
              child: Text("Try To Other Email"),
            ),
          ],
        ),
      );
    }
    EasyLoading.dismiss();
    confirmStage = true;
    stage1 = false;
    emailError = '';
    passwordError = '';
  }

  void _saveDataInDataBase() async {
    final user = UserModel(
      firstName: firstNameControllar.text,
      lastName: lastNameControllar.text,
      email: emailControllar.text,
      password: passwordControllar.text,
      imageUrl: imageUrl!,
      nidNumber: nidControllar.text,
      phone: phoneControllar.text,
      gender: selectedGender!,
      dateOfBirth: _date!,
      age: "18",
      bloodGroup: selectedBloodGroup!,
      address: selectedAddress!,
      isDonor: isDonor,
      isAdmin: false,
    );
    final rowId = await userProvider!.insertUser(user);
    userProvider?.userModel = user;
    await setLoginStatus(true);
    await setUserId(rowId);
    if (mounted)
      Navigator.pushReplacementNamed(context, LauncherPage.routeName);
  }

  void _selectGender() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
              onPressed: () {
                selectedGender = "Female";
                Navigator.pop(context);
                setState(() {});
              },
              child: const Text("🙋‍♀Female")),
          CupertinoActionSheetAction(
              onPressed: () {
                selectedGender = "Male";
                Navigator.pop(context);
                setState(() {});
              },
              child: const Text("🤵Male"))
        ],
        cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
      ),
    );
  }
}
