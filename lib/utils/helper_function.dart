import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'const.dart';

Future<bool> setLoginStatus(bool status) async {
  final pref = await SharedPreferences.getInstance();
  return pref.setBool(isLoggedIn, status);
}

Future<bool> getLoginStatus() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getBool(isLoggedIn) ?? false;
}

Future<bool> setUserId(int id) async {
  final pref = await SharedPreferences.getInstance();
  return pref.setInt(userId, id);
}

Future<int> getUserId() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getInt(userId) ?? 0;
}

void showCustomAlertDialog(
  BuildContext context,
  String nMsg,
  String pMsg,
  String msg,
  Function(String value) onclick,
) {
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
        msg,
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

            final file =
                await ImagePicker().pickImage(source: ImageSource.camera);
            onclick(file!.path);
          },
          child: Text(nMsg),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () async {
            Navigator.pop(context);
            final file =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            onclick(file!.path);
          },
          child: Text(pMsg),
        ),
      ],
    ),
  );
}

void showCorrectMsg(String msg,BuildContext context){
  showDialog(context: context, builder: (context) =>
      AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hold On", style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black)),
            const SizedBox(height: 16),
            Text(
              msg,
              style: const TextStyle(fontSize: 14,color: Colors.black),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: const Text("Ok", style: TextStyle(color: Colors.white, fontSize: 16.0), ),
                ),
              ),
            )
          ],
        ),
        contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomLeft: Radius.circular(50))),
      )
    );
}
void showErrorMsg(String msg,BuildContext context){
  showDialog(context: context, builder: (context) => AlertDialog(
    backgroundColor: Colors.white,
    content: Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(height: 120, color: Colors.red),
              Column(
                children: [
                  Icon(Icons.warning, color: Colors.white, size: 32),
                  SizedBox(height: 8,),
                  Text('OOPs...', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 18)),
                ],
              )
            ],
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(msg, style: TextStyle(fontSize: 14,)),
          ),
          SizedBox(height: 16,),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(color:  Colors.red, borderRadius: BorderRadius.circular(10),),
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text("Try again", style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
          ),
          SizedBox(height: 16,),
        ],
      ),
    ),
    contentPadding: EdgeInsets.all(0),
  ),);
}

void selectBloodGroupUi(BuildContext context, onClick(value)) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("A+");
            },
            child: const Text("A+")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("A-");
            },
            child: const Text("A-")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("B+");
            },
            child: const Text("B+")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("B-");
            },
            child: const Text("B-")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("AB+");
            },
            child: const Text("AB+")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("AB-");
            },
            child: const Text("AB-")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("O+");
            },
            child: const Text("O+")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("O-");
            },
            child: const Text("O-")),
      ],
      cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel")),
    ),
  );
}

void selectAddressGroupUi(BuildContext context, onClick(value)) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("Uttara");
            },
            child: const Text("Uttara")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("Khilkhet");
            },
            child: const Text("Khilkhet")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("Banani");
            },
            child: const Text("Banani")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("Mohakhali");
            },
            child: const Text("Mohakhali")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("Framgate");
            },
            child: const Text("Framgate")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("Shyamoli");
            },
            child: const Text("Shyamoli")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("Badda");
            },
            child: const Text("Badda")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              onClick("Motijheel");
            },
            child: const Text("Motijheel")),
      ],
      cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel")),
    ),
  );
}