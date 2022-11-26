const String tableComment = 'tbl_comment';
const String tblCommentId = 'comment_id';
const String tblCommentDonorId = 'donor_id';
const String tblCommentCommenterId = 'commenter_id';
const String tblCommentRating = 'rating';
const String tblCommentCommenterName = 'commenter_name';
const String tblCommentDonorName = 'donor_name';
const String tblComment = 'comment';
const String tblCommentTime = 'comment_time';

class CommentModel {
  int? commentId;
  int donorId;
  int commenterId;
  double rating;
  String commenterName;
  String donorName;
  String comment;
  String commentTime;

  CommentModel(
      {this.commentId,
      required this.donorId,
      required this.commenterId,
      required this.rating,
      required this.commenterName,
      required this.donorName,
      required this.comment,
      required this.commentTime});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblCommentDonorId: donorId,
      tblCommentCommenterId: commenterId,
      tblCommentRating: rating,
      tblCommentCommenterName: commenterName,
      tblCommentDonorName: donorName,
      tblComment: comment,
      tblCommentTime: commentTime,
    };
    if (commentId != null) {
      map[tblCommentId] = commentId;
    }
    return map;
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) => CommentModel(
        commentId: map[tblCommentId],
        donorId: map[tblCommentDonorId],
        commenterId: map[tblCommentCommenterId],
        rating: map[tblCommentRating],
        commenterName: map[tblCommentCommenterName],
        donorName: map[tblCommentDonorName],
        comment: map[tblComment],
        commentTime: map[tblCommentTime],
      );
}
