import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  static const id = "fdadsad";
  const HistoryPage({super.key});
  
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final Stream<QuerySnapshot> collectionReference =
      FirebaseFirestore.instance.collection('ArchivedOrders').snapshots();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd.MM.yyyy').format(now);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('История заказов - $formattedDate'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionReference,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Нет данных'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              bool isDone = data['isDone'] ?? false;

              return Card(
                child: ListTile(
                  title: Text(data['mahsulot_nomi']),
                  subtitle: Text('Количество: ${data['count']}'),
                  trailing: Icon(
                    isDone ? Icons.check_circle : Icons.cancel,
                    color: isDone ? Colors.green : Colors.red,
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
