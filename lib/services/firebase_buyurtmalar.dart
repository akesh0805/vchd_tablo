import 'package:cloud_firestore/cloud_firestore.dart';  
import 'package:flutter/material.dart';  
import '../model/response.dart';  

final FirebaseFirestore _firestore = FirebaseFirestore.instance;  
final CollectionReference _collection = _firestore.collection('Buyurtmalar');  

class FirebaseCrudBuyurtmalar {  
  // Метод для добавления элемента  
  static Future<Response> addOrder({  
    required String name,  
    required String count,  
    required String id,  
    required String createdAt,  
  }) async {  
    Response response = Response();  
    DocumentReference documentReferencer = _collection.doc();  

    Map<String, dynamic> data = <String, dynamic>{  
      "mahsulot_nomi": name,  
      "count": count,  
      "id": id,  
      "isDone": false, // Добавляем поле isDone по умолчанию false  
      "createdAt": FieldValue.serverTimestamp(), // Добавляем дату и время создания  
    };  

    try {  
      await documentReferencer.set(data);  
      response.code = 200;  
      response.message = "Махсулот добавлен";  
    } catch (e) {  
      response.code = 500;  
      response.message = "Ошибка при добавлении: $e";  
    }  

    return response;  
  }  

  // Метод для обновления элемента  
  static Future<Response> updateOrder({  
    required String docId,  
    required Map<String, dynamic> data,  
  }) async {  
    Response response = Response();  
    DocumentReference documentReferencer = _collection.doc(docId);  

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
  static Stream<QuerySnapshot> readOrders() {  
    return _collection.snapshots();  
  }  

  // Метод для удаления элемента  
  static Future<Response> deleteOrder({  
    required String docId,  
  }) async {  
    Response response = Response();  
    DocumentReference documentReferencer = _collection.doc(docId);  

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
