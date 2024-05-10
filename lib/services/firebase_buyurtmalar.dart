import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Buyurtmalar');

class FirebaseCrudBuyurtmalar {
  static Future<Response> addEmployee({
    required String name,
    required String count,
    required String id,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "mahsulot_nomi": name,
      "count": count,
      "id": id,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> updateEmployee({
    required String name,
    required String count,
    required String id,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "mahsulot_nomi": name,
      "count": count,
      "id": id,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readEmployee() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> deleteEmployee({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Deleted Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
