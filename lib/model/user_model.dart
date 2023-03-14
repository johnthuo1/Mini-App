// User model for the application 
class UserModel {
  String? uid;
  String? email;
  String? userName;

  UserModel({this.uid, this.email,this.userName});

  // receiving data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
    };
  }
}
