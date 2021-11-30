import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  Future<String> addImageInFireBase({XFile xFile, String idAccount}) async {
    File file = File(xFile.path);
    String downloadUrl;
    int temp;
    firebaseFirestore.collection('baby').get().then((querySnapshot) {
      temp = querySnapshot.size;
    });
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('baby/' + temp.toString() + '_' + idAccount);
      UploadTask uploadTask = storageReference.putFile(file);
      await uploadTask;
      TaskSnapshot taskSnapshot = await uploadTask
          .whenComplete(() => print('added image baby in firebase'));
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e);
    }
    return downloadUrl;
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
