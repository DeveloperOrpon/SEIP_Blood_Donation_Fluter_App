import 'package:blood_donation/database/db_helper.dart';
import 'package:blood_donation/model/user_model.dart';
import 'package:blood_donation/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAddress extends StatefulWidget {
  final UserModel userModel;
  final VoidCallback onUpdateComplite;
  const EditAddress({Key? key, required this.userModel, required this.onUpdateComplite}) : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final addressController = TextEditingController();
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    firstController.dispose();
    lastController.dispose();
    phoneController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    addressController.text = widget.userModel.address;
    firstController.text = widget.userModel.firstName;
    lastController.text = widget.userModel.lastName;
    phoneController.text = widget.userModel.phone;
    passwordController.text = widget.userModel.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Information Edit!!',
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
              controller: firstController,
              prefix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(CupertinoIcons.person),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              controller: lastController,
              prefix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(CupertinoIcons.person_2_alt),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              controller: addressController,
              prefix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(CupertinoIcons.location_solid),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              controller: passwordController,
              prefix: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(CupertinoIcons.lock),
              ),
              keyboardType: TextInputType.text,
            ),
            CupertinoTextField(
              controller: phoneController,
              prefix: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(CupertinoIcons.phone),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _saveEditData,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: const Center(
                  child: Text("Apply Change",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveEditData() async {
    final editUser = UserModel(
      userId: widget.userModel.userId,
      firstName: firstController.text,
      lastName: lastController.text,
      email: widget.userModel.email,
      password: passwordController.text,
      imageUrl: widget.userModel.imageUrl,
      nidNumber: widget.userModel.nidNumber,
      phone: phoneController.text,
      gender: widget.userModel.gender,
      dateOfBirth: widget.userModel.dateOfBirth,
      age: widget.userModel.age,
      bloodGroup: widget.userModel.bloodGroup,
      address: addressController.text,
      isDonor: widget.userModel.isDonor,
      isAdmin: widget.userModel.isDonor,
    );
    final userProvider = Provider.of<UserProvider>(context, listen: false);
   int rowId=await userProvider.updateUserAddress(editUser);
    userProvider.userModel=editUser;
    print("Row Id $rowId");
    Navigator.pop(context);
    widget.onUpdateComplite();
  }
}
