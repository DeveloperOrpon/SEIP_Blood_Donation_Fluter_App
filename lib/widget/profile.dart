import 'dart:io';
import 'package:blood_donation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

import 'DonorProfle.dart';
import 'alert.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const String routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ;
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, provider, child) => SafeArea(
            child: provider
                    .userModel
                    .isDonor
                ?  DonorProfile(userProvider: provider,)
                :  DonorProfile(userProvider: provider,),
      ),
      )
    );
  }
}
