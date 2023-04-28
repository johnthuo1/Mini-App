// User model for the application 
class UserModel {
  String? uid;
  String? email;
  String? userName;
  String? profilePicture;

  UserModel({this.uid, this.email,this.userName, this.profilePicture});


  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      profilePicture: map['profilePicture'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
      'profilePicture': profilePicture,
    };
  }
}




