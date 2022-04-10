import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/baby/ni_model.dart';
import '../../../utils/converter.dart';
import 'package:uuid/uuid.dart';

class NIRepository {
  static Future<void> createNi(NIModel niModel, String idBaby) async {
    bool isVariable = false;
    String type = Converter.niTypeToString(niModel.type);
    DocumentReference docRef;
    var batch = FirebaseFirestore.instance.batch();
    await FirebaseFirestore.instance
        .collection('ni')
        .where('idBaby', isEqualTo: idBaby)
        .where('type', isEqualTo: type)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());
        isVariable = true;
        Map<String, dynamic> data = doc.data();
        docRef = FirebaseFirestore.instance.collection('ni').doc(doc.id);
        batch.update(docRef, {'value': data['value'] + niModel.value});
        batch.update(docRef, {'updateDate': myTimeStamp});
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
          FirebaseFirestore.instance.collection('ni').doc(idNI);
      String temp = niModel.type.toString();
      await documentReferencer
          .set(niModel.toJson())
          .whenComplete(() => print("$temp ni added to the database"))
          .catchError((e) => print(e));
    }
  }

  static Future<List<NIModel>> fetchNi(String idBaby) async {
    List<NIModel> list;
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('ni')
          .where('idBaby', isEqualTo: idBaby)
          .get();
      list = snapshot.docs.map((doc) => NIModel.fromSnapshot(doc)).toList();
    } catch (error) {
      print(error);
      return null;
    }
    return list;
  }
}
