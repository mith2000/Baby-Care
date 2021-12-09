import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class BabyRepository {
  final FirebaseFirestore firebaseFirestore;

  BabyRepository({FirebaseFirestore firebaseFirestore})
      : this.firebaseFirestore =
            firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<BabyModel>> fetchAllBaby(String userId) {
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
    int temp;
    await firebaseFirestore.collection('baby').get().then((querySnapshot) {
      temp = querySnapshot.size;
    });
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('baby/' + temp.toString() + '_' + idAccount);
      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask
          .whenComplete(() => print('added image baby in firebase'));
      return await taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<String> createBaby({BabyModel babyModel}) async {
    String idBaby = Uuid().v4();
    babyModel.setID(idBaby);
    DocumentReference documentReferencer =
        firebaseFirestore.collection('baby').doc(idBaby);
    await documentReferencer
        .set(babyModel.toJson())
        .catchError((e) => e.toString())
        .whenComplete(() => print('baby added to the database'));
    return idBaby;
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
