import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simba/models/user_model.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> saveUser(String name, int waterCounter) async {
    // return await userCollection
    //     .doc(uid)
    //     .set({'name': name, 'waterCount': waterCounter});
  }

  UserM _userFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return UserM(
      name: data['name'],
      profilePic: data['profilePic'],
      uid: uid,
      isAuthenticated: data['isAuthenticated'],
      communities: data['communities'],
    );
  }

  Stream<UserM> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<UserM> _userListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<UserM>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}
