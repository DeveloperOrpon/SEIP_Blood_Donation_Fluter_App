import 'package:blood_donation/database/db_helper.dart';
import 'package:flutter/material.dart';
import '../model/blood_donate_post.dart';
import '../model/comment_model.dart';

class CommentProvider extends ChangeNotifier {

  Future<int> addComment(CommentModel commentModel)=>DbHelper.addComment(commentModel);
  Future<bool> didUserComment(int commenterId, int donorId)=>DbHelper.didUserComment(commenterId, donorId);
  Future<List<CommentModel>> getComments(int donorId)=>DbHelper.getComments(donorId);
}