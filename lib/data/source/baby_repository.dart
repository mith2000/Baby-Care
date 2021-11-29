import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<String> addImageInFireBase({XFile xFile, String idBaby}) async {
    File file = File(xFile.path);
    var downloadUrl;
    try {
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;

      var snapshot = await storage.ref().child('baby/$file.path').putFile(file);
      downloadUrl = await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e);
    }
    return downloadUrl;

    // return downloadUrl;
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

  Stream<void> updateBaby({String idBaby, BabyModel babyModel}) {
    DocumentReference documentReferencer =
        firebaseFirestore.collection('baby').doc(idBaby);
    documentReferencer
        .update(babyModel.toJson())
        .whenComplete(() => print("Baby updated in the database"))
        .catchError((e) => print(e));
    return firebaseFirestore.collection('baby').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => BabyModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<void> deleteBaby({String idBaby}) {
    DocumentReference documentReferencer =
        firebaseFirestore.collection('baby').doc(idBaby);

    documentReferencer
        .delete()
        .whenComplete(() => print('Baby deleted from the database'))
        .catchError((e) => print(e));

    return firebaseFirestore.collection('baby').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => BabyModel.fromSnapshot(doc)).toList();
    });
  }
}
