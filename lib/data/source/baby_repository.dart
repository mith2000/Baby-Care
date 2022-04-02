import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class BabyRepository {
  static Future<BabyModel> fetchBaby(String idBaby) async {
    BabyModel babyModel;
    var document = await FirebaseFirestore.instance
        .collection('baby')
        .doc(idBaby)
        .snapshots()
        .map((doc) => babyModel = BabyModel.fromSnapshot(doc));
    return babyModel;
  }

  static Future<List<BabyModel>> fetchAllBaby(String userId) async {
    List<BabyModel> list;
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('baby')
          .where('idAccount', isEqualTo: userId)
          .get();
      list = snapshot.docs.map((doc) => BabyModel.fromSnapshot(doc)).toList();
    } catch (error) {
      print(error);
      return null;
    }
    return list;
  }

  static Future<String> addImageInFireBase(
      {XFile xFile, String idAccount}) async {
    File file = File(xFile.path);
    int temp;
    await FirebaseFirestore.instance
        .collection('baby')
        .get()
        .then((querySnapshot) {
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

  static Future<List<BabyModel>> createBaby({BabyModel babyModel}) async {
    String idBaby;
    if (babyModel.id == null) {
      idBaby = Uuid().v4();
      babyModel.setID(idBaby);
    } else {
      idBaby = babyModel.id;
    }
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('baby').doc(idBaby);
    await documentReferencer
        .set(babyModel.toJson())
        .catchError((e) => e.toString())
        .whenComplete(() => print('baby added to the database'));
    return await fetchAllBaby(babyModel.idAccount);
  }

  static Future<BabyModel> updateBaby({BabyModel babyModel}) async {
    BabyModel _babyModel;
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('baby').doc(babyModel.id);
    documentReferencer
        .update(babyModel.toJson())
        .whenComplete(() =>
            {print("Baby updated in the database"), _babyModel = babyModel})
        .catchError((e) => print(e));
    return _babyModel;
  }

  static Future<List<BabyModel>> deleteBaby({String idBaby}) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('baby').doc(idBaby);
    documentReferencer
        .delete()
        .whenComplete(() => print('Baby deleted from the database'))
        .catchError((e) => print(e));
    List<BabyModel> list;
    await FirebaseFirestore.instance
        .collection('baby')
        .snapshots()
        .map((snapshot) {
      list = snapshot.docs.map((doc) => BabyModel.fromSnapshot(doc)).toList();
    });
    return list;
  }
}
