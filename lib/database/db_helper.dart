import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import '../model/blood_donate_post.dart';
import '../model/comment_model.dart';
import '../model/favorite_model.dart';
import '../model/user_model.dart';
import '../utils/const.dart';

class DbHelper {
  static const String createTableUser = '''create table $tableUser(
  $tblUserColId integer primary key autoincrement,
  $tblUserColFirstName text,
  $tblUserColLastName text,
  $tblUserColEmail text,
  $tblUserColPassword text,
  $tblUserColImageUrl text,
  $tblUserColNidNumber text,
  $tblUserColPhone text,
  $tblUserColGender text,
  $tblUserColDateOfBirth text,
  $tblUserColAge text,
  $tblUserColBloodGroup text,
  $tblUserColAddress text,
  $tblUserColIsDonor integer,
  $tblUserColIsAdmin integer)''';

  static const String createDonorPost = '''create table $tableDonorPost(
  $tblDonorColPostId integer primary key autoincrement,
  $tblDonorColUserId integer,
  $tblDonorColDonorName text,
  $tblDonorColBloodGroup text,
  $tblDonorColCity text,
  $tblDonorColState text,
  $tblDonorColDonorImage text,
  $tblDonorColPostTime text,
  $tblDonorColActive integer)''';

  static const String createCommentTable = '''create table $tableComment(
  $tblCommentId integer primary key autoincrement,
  $tblCommentDonorId integer,
  $tblCommentCommenterId integer,
  $tblCommentRating real,
  $tblCommentCommenterName text,
  $tblCommentDonorName text,
  $tblComment text,
  $tblCommentTime text)''';

  static const String createFavoriteTable = '''create table $tableFavorite(
  $tblFavId integer primary key autoincrement,
  $tblFavColUserId integer,
  $tblFavDonorId integer,
  $tblFavDonorName text,
  $tblFavDonorImage text,
  $tblFavDonorBloodGroup text,
  $tblFavLastDonate text)''';

  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = Path.join(rootPath, 'blood_donation');

    return openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      await db.execute(createTableUser);
      await db.execute(createDonorPost);
      await db.execute(createCommentTable);
      await db.execute(createFavoriteTable);
    });
  }

  //user query
  static Future<int> insertUser(UserModel userModel) async {
    final db = await open();
    return db.insert(tableUser, userModel.toMap());
  }

  static Future<UserModel?> getUserByEmail(String email) async {
    final db = await open();
    final mapList = await db.query(
      tableUser,
      where: '$tblUserColEmail = ?',
      whereArgs: [email],
    );
    if (mapList.isEmpty) return null;
    return UserModel.fromMap(mapList.first);
  }

  static Future<UserModel?> getUserByUserId(int id) async {
    final db = await open();
    final mapList = await db.query(
      tableUser,
      where: '$tblUserColId = ?',
      whereArgs: [id],
    );
    if (mapList.isEmpty) return null;
    return UserModel.fromMap(mapList.first);
  }

  static Future<int> updateUserAddress(UserModel userModel) async {
    final db = await open();
    return db.update(
      tableUser,
      userModel.toMap(),
      where: '$tblUserColId = ?',
      whereArgs: [userModel.userId],
    );
  }

  //donor query
  static Future<int> insertDonorPost(
      BloodDonatePostModel bloodDonatePostModel) async {
    final db = await open();
    return db.insert(tableDonorPost, bloodDonatePostModel.toMap());
  }

  static Future<BloodDonatePostModel?> getDonatePostByUserId(int id) async {
    final db = await open();
    final mapList = await db.query(
      tableDonorPost,
      where: '$tblDonorColUserId = ?',
      whereArgs: [id],
    );
    if (mapList.isEmpty) return null;
    return BloodDonatePostModel.fromMap(mapList.first);
  }

  static Future<bool> didDonorPost(int userId) async {
    final db = await open();
    final mapList = await db.query(tableDonorPost,
        where: '$tblDonorColUserId = ?', whereArgs: [userId]);
    return mapList.isNotEmpty;
  }

  static Future<int> updateDonarPost(
      BloodDonatePostModel bloodDonatePostModel) async {
    final db = await open();
    return db.update(
      tableDonorPost,
      bloodDonatePostModel.toMap(),
      where: '$tblUserColId = ?',
      whereArgs: [bloodDonatePostModel.userId],
    );
  }

  static Future<BloodDonatePostModel> getUserPost(int userId) async {
    final db = await open();
    final mapList = await db.query(
      tableDonorPost,
      where: '$tblDonorColUserId = ?',
      whereArgs: [userId],
    );
    return BloodDonatePostModel.fromMap(mapList.first);
  }


  static Future<List<BloodDonatePostModel>> getPostByBloodGroup(String bloodGroup) async {
    final db = await open();
    final mapList = await db.query(tableDonorPost,
      where: '$tblDonorColBloodGroup = ?',
      whereArgs: [bloodGroup],
    );
    return List.generate(mapList.length,
            (index) => BloodDonatePostModel.fromMap(mapList[index]));
  }
  static Future<List<BloodDonatePostModel>> getPostByBloodGroupAndLocation(String bloodGroup,String location) async {
    final db = await open();
    final mapList = await db.query(tableDonorPost,
      where: '$tblDonorColBloodGroup = ? and $tblDonorColCity = ?',
      whereArgs: [bloodGroup,location],
    );
    return List.generate(mapList.length,
            (index) => BloodDonatePostModel.fromMap(mapList[index]));
  }

  //comment database
  static Future<int> addComment(CommentModel commentModel) async {
    final db = await open();
    return db.insert(tableComment, commentModel.toMap());
  }

  static Future<bool> didUserComment(int commenterId, int donorId) async {
    final db = await open();
    final mapList = await db.query(tableComment,
        where: '$tblCommentCommenterId = ? and $tblCommentDonorId = ?',
        whereArgs: [commenterId, donorId]);
    return mapList.isNotEmpty;
  }

  static Future<List<CommentModel>> getComments(int donorId) async {//WORK
    final db = await open();
    final mapList = await db.query(tableComment,
        where: '$tblCommentDonorId = ?', whereArgs: [donorId]);
    if (mapList.isEmpty) {
      return [];
    }
    return List.generate(
        mapList.length, (index) => CommentModel.fromMap(mapList[index]));
  }

  static Future<List<BloodDonatePostModel>> getAllDonationPost() async {
    final db = await open();
    final mapList = await db.query(tableDonorPost);
    if (mapList.isEmpty) {
      return [];
    }
    return List.generate(mapList.length,
            (index) => BloodDonatePostModel.fromMap(mapList[index]));
  }

  // favorite query
  static Future<int> addFavorite(FavoriteModel favoriteModel) async {
    final db = await open();
    return db.insert(tableFavorite, favoriteModel.toMap());
  }
  static Future<bool> didDonorIsFavorite(int userId, int donorId) async {
    final db = await open();
    final mapList = await db.query(tableFavorite,
        where: '$tblFavColUserId = ? and $tblFavDonorId = ?',
        whereArgs: [userId, donorId]);
    return mapList.isNotEmpty;
  }

  static Future<List<FavoriteModel>> getFavorite(int userId) async {
    final db = await open();
    final mapList = await db.query(tableFavorite,
        where: '$tblFavColUserId = ?', whereArgs: [userId]);
    if (mapList.isEmpty) {
      return [];
    }
    return List.generate(
        mapList.length, (index) => FavoriteModel.fromMap(mapList[index]));
  }

  //avg rating cal
  static Future<Map<String, dynamic>> getAvgOfDonorRating(int donorId) async {
    final db = await open();
    final mapList = await db.rawQuery('SELECT AVG($tblCommentRating) as $avgRating FROM $tableComment WHERE $tblCommentDonorId = $donorId');
    return mapList.first;
  }
}
