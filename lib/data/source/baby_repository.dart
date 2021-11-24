import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';

class BabyRepository {
  final FirebaseFirestore firebaseFirestore;

  BabyRepository({FirebaseFirestore firebaseFirestore})
      : this.firebaseFirestore =
            firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<BabyModel>> getAllBaby(String userId) {
    return firebaseFirestore
        .collection('baby')
        .where('idAccount', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => BabyModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<void> addItem({BabyModel babyModel}) {
    DocumentReference documentReferencer =
        firebaseFirestore.collection('baby').doc();

    documentReferencer
        .set(babyModel.toJson())
        .whenComplete(() => print("baby added to the database"))
        .catchError((e) => print(e));

    return firebaseFirestore.collection('baby').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => BabyModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<void> updateBaby({String docId, BabyModel babyModel}) {
    DocumentReference documentReferencer =
        firebaseFirestore.collection('baby').doc(docId);
    documentReferencer
        .update(babyModel.toJson())
        .whenComplete(() => print("Baby updated in the database"))
        .catchError((e) => print(e));
    return firebaseFirestore.collection('baby').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => BabyModel.fromSnapshot(doc)).toList();
    });
  }
}
