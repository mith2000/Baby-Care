import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_babycare/data/model/ni_model.dart';
import 'package:flutter_babycare/utils/converter.dart';
import 'package:uuid/uuid.dart';

class NIRepository {
  final FirebaseFirestore firebaseFirestore;

  NIRepository({FirebaseFirestore firebaseFirestore})
      : this.firebaseFirestore =
            firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> createNi(NIModel niModel, String idBaby) async {
    bool isVariable = false;
    String type = Converter.niTypeToString(niModel.type);
    DocumentReference docRef;
    var batch = FirebaseFirestore.instance.batch();
    await firebaseFirestore
        .collection('ni')
        .where('idBaby', isEqualTo: idBaby)
        .where('type', isEqualTo: type)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        isVariable = true;
        Map<String, dynamic> data = doc.data();
        docRef = firebaseFirestore.collection('ni').doc(doc.id);
        batch.update(docRef, {'value': data['value'] + niModel.value});
        batch.commit().then((a) {
          print('updated $type NI');
        });
      });
    }).catchError((error) {
      print(error);
    });
    if (!isVariable) {
      String idNI = Uuid().v4();
      niModel.setID(idNI);
      DocumentReference documentReferencer =
          firebaseFirestore.collection('ni').doc(idNI);
      String temp = niModel.type.toString();
      await documentReferencer
          .set(niModel.toJson())
          .whenComplete(() => print("$temp ni added to the database"))
          .catchError((e) => print(e));
    }
  }

  Stream<List<NIModel>> fetchNi(String idBaby) {
    return firebaseFirestore
        .collection('ni')
        .where('idBaby', isEqualTo: idBaby)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => NIModel.fromSnapshot(doc)).toList();
    });
  }
}
