const String tableFavorite = 'tbl_favorite';
const String tblFavId = 'fav_id';
const String tblFavColUserId = 'user_id';
const String tblFavDonorId = 'donor_id';
const String tblFavDonorName = 'donor_name';
const String tblFavDonorImage = 'donor_image';
const String tblFavDonorBloodGroup = 'donor_blood';
const String tblFavLastDonate = 'last_donate';

class FavoriteModel {
  int? favId;
  int userId;
  int donorId;
  String donorName;
  String donorImage;
  String donorBloodGroup;
  String lastDateOfDonate;

  FavoriteModel(
      {this.favId,
      required this.userId,
      required this.donorId,
      required this.donorName,
      required this.donorImage,
      required this.donorBloodGroup,
      required this.lastDateOfDonate});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblFavColUserId: userId,
      tblFavDonorId: donorId,
      tblFavDonorImage:donorImage,
      tblFavDonorName: donorName,
      tblFavDonorBloodGroup: donorBloodGroup,
      tblFavLastDonate: lastDateOfDonate
    };
    if (favId != null) {
      map[tblFavId] = favId;
    }
    return map;
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) => FavoriteModel(
      favId: map[tblFavId],
      userId: map[tblFavColUserId],
      donorId: map[tblFavDonorId],
      donorName: map[tblFavDonorName],
      donorImage:map[tblFavDonorImage] ,
      donorBloodGroup: map[tblFavDonorBloodGroup],
      lastDateOfDonate: map[tblFavLastDonate]);
}
