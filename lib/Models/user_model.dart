class UserModel {
  String uid;
  String? username;
  String? phoneNumber;

  UserModel(
      this.uid,
      this.username,
      this.phoneNumber,
      );

  getUID() => uid;
  getUsername() => username;
  getPhone() => phoneNumber;

  setUID(uid) => this.uid;
  setUsername(username) => this.username;
  setPhone(phoneNumber) => this.phoneNumber;
}


// class UserModel{
//   static const NUMBER = "number";
//   static const ID = "id";
//
//   dynamic _number;
//   dynamic _id;
//
//   UserModel(
//       this._id,
//       this._number,
//       );
//
// //  getters
//   String get number => _number;
//   String get id => _id;
//
//   UserModel.fromSnapshot(DocumentSnapshot snapshot) {
//     _number = snapshot.data();
//     _id = snapshot.data();
//   }
// }

// class PhoneUser {
//   late final String uid;
//   late final String? phoneNumber;
//
//   PhoneUser(
//       this.uid,
//       this.phoneNumber,
//       );
//
//   PhoneUser.fromFirebaseUser({required User user}) {
//     uid = user.uid;
//     phoneNumber = user.phoneNumber;
//   }
// }