import 'package:blood_donation/model/blood_donate_post.dart';
import 'package:flutter/cupertino.dart';
import '../database/db_helper.dart';
import '../model/comment_model.dart';
import '../model/favorite_model.dart';
import '../model/user_model.dart';

class UserProvider extends ChangeNotifier {
  late UserModel userModel;
  BloodDonatePostModel? bloodDonatePostModel;
//bool activeDonate=widget.userProvider.bloodDonatePostModel!.isActive;
  String _bloodGroup = '';

  String get selectBlood => _bloodGroup;

  set selectBlood(String value) {
    _bloodGroup = value;
    notifyListeners();
  }

  String _searchValue='';
  String get searchValue => _searchValue;

  set searchValue(String value) {
    _searchValue = value;
    notifyListeners();
  }

  bool _activeDonate=true;
  bool get activeDonate => _activeDonate;

  set activeDonate(bool value) {
    _activeDonate = value;
    notifyListeners();
  }

  Future<UserModel?> getUserByEmail(String email) =>
      DbHelper.getUserByEmail(email);

  Future<UserModel?> getUserByUserId(int id) => DbHelper.getUserByUserId(id);

  Future<int> insertUser(UserModel userModel) => DbHelper.insertUser(userModel);

  Future<int> updateUserAddress(UserModel userModel) =>
      DbHelper.updateUserAddress(userModel);

  //donate post
  Future<int> insertDonorPost(BloodDonatePostModel bloodDonatePostModel) =>
      DbHelper.insertDonorPost(bloodDonatePostModel);

  Future<BloodDonatePostModel?> getDonatePostByUserId(int id) =>
      DbHelper.getDonatePostByUserId(id);

  Future<bool> didDonorPost(int userId) => DbHelper.didDonorPost(userId);

  Future<int> updateDonarPost(BloodDonatePostModel bloodDonatePostModel) =>
      DbHelper.updateDonarPost(bloodDonatePostModel);
  Future<List<BloodDonatePostModel>> findAllDonationPost()=>DbHelper.getAllDonationPost();
  Future<List<BloodDonatePostModel>> getPostByBloodGroup(String bloodGroup)=>DbHelper.getPostByBloodGroup(bloodGroup);
  Future<List<BloodDonatePostModel>> getPostByBloodGroupAndLocation(String bloodGroup,String location)=>DbHelper.getPostByBloodGroupAndLocation(bloodGroup, location);
  List<BloodDonatePostModel> donationPostList = [];

  void getAllDonationPost() async {
    donationPostList = await DbHelper.getAllDonationPost();
    notifyListeners();
  }
  Future<List<CommentModel>> getComments(int donorId)=>DbHelper.getComments(donorId);
  ///favorite

  Future<int> addFavorite(FavoriteModel favoriteModel)=>DbHelper.addFavorite(favoriteModel);
  Future<bool> didDonorIsFavorite(int userId, int donorId)=>DbHelper.didDonorIsFavorite(userId, donorId);
  Future<List<FavoriteModel>> getFavorite(int userId)=>DbHelper.getFavorite(userId);
  Future<Map<String, dynamic>> getAvgOfDonorRating(int donorId)=>DbHelper.getAvgOfDonorRating(donorId);
}
