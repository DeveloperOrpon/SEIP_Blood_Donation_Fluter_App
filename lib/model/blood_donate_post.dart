const String tableDonorPost = 'tbl_donor_post';
const String tblDonorColPostId = 'post_id';
const String tblDonorColUserId = 'user_id';
const String tblDonorColDonorName = 'donor_name';
const String tblDonorColBloodGroup = 'blood_group';
const String tblDonorColCity = 'donor_city';
const String tblDonorColState = 'donor_state';
const String tblDonorColPostTime = 'post_time';
const String tblDonorColActive = 'is_active';
const String tblDonorColDonorImage = 'image_url';

class BloodDonatePostModel{
  int? postId;
  int userId;
  String donorName;
  String donorImageUrl;
  String bloodGroup;
  String state;
  String city;
  String postTime;
  bool isActive;

  BloodDonatePostModel(
      {
        this.postId,
        required this.donorImageUrl,
   required this.userId,
   required this.donorName,
   required this.bloodGroup,
   required this.state,
   required this.city,
   required this.postTime,
   required this.isActive,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblDonorColUserId: userId,
      tblDonorColDonorName: donorName,
      tblDonorColBloodGroup: bloodGroup,
      tblDonorColState: state,
      tblDonorColDonorImage:donorImageUrl,
      tblDonorColCity: city,
      tblDonorColPostTime: postTime,
      tblDonorColActive: isActive ? 1 : 0,
    };
    if (postId != null) {
      map[tblDonorColPostId] = postId;
    }
    return map;
  }
  factory BloodDonatePostModel.fromMap(Map<String, dynamic> map) =>
      BloodDonatePostModel(
        postId:map[tblDonorColPostId],
        userId: map[tblDonorColUserId],
        donorName: map[tblDonorColDonorName],
        bloodGroup: map[tblDonorColBloodGroup],
        state: map[tblDonorColState],
        donorImageUrl: map[tblDonorColDonorImage],
        city: map[tblDonorColCity],
        postTime: map[tblDonorColPostTime],
        isActive: map[tblDonorColActive] == 1 ? true : false,
      );
}