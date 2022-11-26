const String tableUser = 'tbl_user';
const String tblUserColId = 'user_id';
const String tblUserColFirstName = 'first_name';
const String tblUserColLastName = 'last_name';
const String tblUserColEmail = 'user_email';
const String tblUserColPassword = 'user_password';
const String tblUserColImageUrl = 'user_image';
const String tblUserColNidNumber = 'user_nid';
const String tblUserColPhone = 'user_phone';
const String tblUserColGender = 'gender';
const String tblUserColDateOfBirth = 'date_of_birth';
const String tblUserColAge = 'user_age';
const String tblUserColBloodGroup = 'blood_group';
const String tblUserColAddress = 'user_address';
const String tblUserColIsDonor = 'is_donor';
const String tblUserColIsAdmin = 'is_admin';

class UserModel {
  int? userId;
  String firstName;
  String lastName;
  String email;
  String password;
  String imageUrl;
  String nidNumber;
  String phone;
  String gender;
  String dateOfBirth;
  String age;
  String bloodGroup;
  String address;
  bool isDonor;
  bool isAdmin;

  UserModel({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.imageUrl,
    required this.nidNumber,
    required this.phone,
    required this.gender,
    required this.dateOfBirth,
    required this.age,
    required this.bloodGroup,
    required this.address,
    required this.isDonor,
   required this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblUserColFirstName: firstName,
      tblUserColLastName: lastName,
      tblUserColEmail: email,
      tblUserColPassword: password,
      tblUserColImageUrl: imageUrl,
      tblUserColNidNumber: nidNumber,
      tblUserColPhone: phone,
      tblUserColGender: gender,
      tblUserColDateOfBirth: dateOfBirth,
      tblUserColAge: age,
      tblUserColBloodGroup: bloodGroup,
      tblUserColAddress: address,
      tblUserColIsDonor: isDonor ? 1 : 0,
      tblUserColIsAdmin: isAdmin ? 1 : 0,
    };
    if (userId != null) {
      map[tblUserColId] = userId;
    }
    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        userId: map[tblUserColId],
        firstName: map[tblUserColFirstName],
        lastName: map[tblUserColLastName],
        email: map[tblUserColEmail],
        password: map[tblUserColPassword],
        imageUrl: map[tblUserColImageUrl],
        nidNumber: map[tblUserColNidNumber],
        phone: map[tblUserColPhone],
        gender: map[tblUserColGender],
        dateOfBirth: map[tblUserColDateOfBirth],
        age: map[tblUserColAge],
        bloodGroup: map[tblUserColBloodGroup],
        address: map[tblUserColAddress],
        isAdmin: map[tblUserColIsAdmin] == 1 ? true : false,
        isDonor: map[tblUserColIsDonor] == 1 ? true : false,
      );
}
