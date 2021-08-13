import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_first/models/brew.dart';
import 'package:firebase_first/models/user.dart';

class DatabaseService {
  String uid;
  DatabaseService(this.uid);
  final CollectionReference brewData =
      FirebaseFirestore.instance.collection('brews');
  Future<void> updateUserData(String sugar, String name, int strength) async {
    return await brewData.doc(uid).set({
      'sugar': sugar,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.get('name') ?? '',
          strength: doc.get('strength') ?? 0,
          sugar: doc.get('sugar') ?? '0');
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        snapshot.get('sugar'), snapshot.get(' name'), snapshot.get('strength'));
  }

  Stream<List<Brew>> get brewStream {
    return brewData.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewData.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
