import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Buyurtmalar');

class FirebaseCrudBuyurtmalar {
  // Метод для добавления элемента
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
      "isDone": false, // Добавляем поле isDone по умолчанию false
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Махсулот добавлен";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  // Метод для обновления элемента
  static Future<Response> updateEmployee({
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Элемент успешно обновлен";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  // Метод для чтения элементов
  static Stream<QuerySnapshot> readEmployee() {
    CollectionReference notesItemCollection = _Collection;
    return notesItemCollection.snapshots();
  }

  // Метод для удаления элемента
  static Future<Response> deleteEmployee({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Элемент успешно удален";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
