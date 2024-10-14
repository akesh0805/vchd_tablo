import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:html' as html ;

import '../services/firebase_buyurtmalar.dart';

class ZakazlarScreen extends StatefulWidget {
  const ZakazlarScreen({super.key});
  static const id = "Zakazlarruyxati";

  @override
  State<ZakazlarScreen> createState() => _ZakazlarScreenState();
}

class _ZakazlarScreenState extends State<ZakazlarScreen> {
  final Stream<QuerySnapshot> collectionReference2 =
      FirebaseCrudBuyurtmalar.readOrders();
  final ScrollController scrollController1 = ScrollController();
  bool scrollingForward1 = true;
  String date = '';

  @override
  void initState() {
    super.initState();
    date = formatDateTime();
    _startScrolling();
  }

  String formatDateTime() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy-HH:mm:ss');
    return formatter.format(now);
  }

  Future<void> _cleanCollection() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Buyurtmalar').get();

      // Delete all documents in the collection
      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Buyurtmalar ro\'yxati tozalandi')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Xatolik kelib chiqdi: $e')),
      );
    }
  }

  Future<void> _downloadExcelFile() async {
    // Fetch data from Firestore
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Buyurtmalar').get();

    // Create an Excel document
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Add column headers
    sheetObject.appendRow(['Sex nomi', 'Mahsulot nomi', 'Midori', 'Holati']);

    // Add data rows
    for (var doc in querySnapshot.docs) {
      sheetObject.appendRow([
        doc['id']
            .toString()
            .replaceAll('s1', 'ВСЦ')
            .replaceAll('s2', 'КРЦ')
            .replaceAll('s3', 'ТЦ')
            .replaceAll('s4', 'КПА')
            .replaceAll('s5', 'АКП'),
        doc['mahsulot_nomi'],
        doc['count'],
        doc['isDone']
            .toString()
            .replaceAll('true', 'Tayyorlandi')
            .replaceAll('false', 'Tayyorlanmadi')
      ]);
    }

    // Encode the Excel document as bytes
   // Код для веба
  if (kIsWeb) {
    var excelBytes = excel.encode();
    if (excelBytes != null) {
      final blob = html.Blob([excelBytes],
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'orders.xlsx')
        ..click();
      html.Url.revokeObjectUrl(url);
    }
  } else {
    // Код для мобильной версии
    print("Загрузка Excel недоступна на мобильных устройствах.");
  }
  }

  void _startScrolling() {
    Future.delayed(const Duration(minutes: 30), () {
      _scroll1();
    });
  }

  void _scroll1() {
    scrollController1
        .animateTo(
      scrollingForward1
          ? scrollController1.position.maxScrollExtent
          : scrollController1.position.minScrollExtent,
      duration: const Duration(seconds: 50),
      curve: Curves.linear,
    )
        .then((_) {
      scrollingForward1 = !scrollingForward1;
      _scroll1(); // Call _scroll1 again to continue the loop
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Buyurtmalar ro'yxatini o'chirish"),
          content: Text("Buyurtmalar ro'yxatini tozalashni tasdiqlaysizmi?"),
          actions: <Widget>[
            TextButton(
              child: Text('Bekor qilish'),
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог
              },
            ),
            TextButton(
              child: Text("O'chirish"),
              onPressed: () {
                _cleanCollection(); // Вызвать функцию удаления
                Navigator.of(context).pop(); // Закрыть диалог
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController1.dispose();

    super.dispose();
  }

  bool click = true;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd.MM.yyyy').format(now);
    String text = "KUNGI BUYURTMALAR RO'YXATI";
    String appbar = '$formattedDate $text';
    String s1 = "ВСЦ";
    String s2 = "КРЦ";
    String s3 = "ТЦ";
    String s4 = "КПА";
    String s5 = "АКП";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          appbar,
          style: const TextStyle(
            fontSize: 35,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showDeleteConfirmationDialog(
                context), // Показываем диалог подтверждения
            icon: const Icon(Icons.delete),
          ),
        
          IconButton(
            onPressed: () {
              _downloadExcelFile();
            },
            icon: const Icon(Icons.file_download),
          )
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              children: [
                const Text(
                  "ВСЦ",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    controller: scrollController1,
                    children: [
                      StreamBuilder(
                        stream: collectionReference2,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            var filteredDocs = snapshot.data!.docs
                                .where((doc) => doc["id"] == s1)
                                .toList();
                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: filteredDocs.map((doc) {
                                var data = doc.data() as Map<String, dynamic>;
                                bool isDone = data["isDone"] ?? false;

                                return Card(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: IconButton(
                                          onPressed: () async {
                                            var newStatus = !isDone;
                                            var response =
                                                await FirebaseCrudBuyurtmalar
                                                    .updateOrder(
                                              docId: doc.id,
                                              data: {"isDone": newStatus},
                                            );
                                            if (response.code != 200) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(response
                                                        .message
                                                        .toString()),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          icon: Icon(
                                            isDone
                                                ? Icons.done_outline
                                                : Icons.done,
                                            color: isDone ? Colors.green : null,
                                          ),
                                        ),
                                        title: Text(data["mahsulot_nomi"]),
                                        subtitle: Text(data["count"]),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "КРЦ",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      StreamBuilder(
                        stream: collectionReference2,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            var filteredDocs = snapshot.data!.docs
                                .where((doc) => doc["id"] == s2)
                                .toList();
                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: filteredDocs.map((doc) {
                                var data = doc.data() as Map<String, dynamic>;
                                bool isDone = data["isDone"] ?? false;

                                return Card(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: IconButton(
                                          onPressed: () async {
                                            var newStatus = !isDone;
                                            var response =
                                                await FirebaseCrudBuyurtmalar
                                                    .updateOrder(
                                              docId: doc.id,
                                              data: {"isDone": newStatus},
                                            );
                                            if (response.code != 200) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(response
                                                        .message
                                                        .toString()),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          icon: Icon(
                                            isDone
                                                ? Icons.done_outline
                                                : Icons.done,
                                            color: isDone ? Colors.green : null,
                                          ),
                                        ),
                                        title: Text(data["mahsulot_nomi"]),
                                        subtitle: Text(data["count"]),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "ТЦ",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      StreamBuilder(
                        stream: collectionReference2,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            var filteredDocs = snapshot.data!.docs
                                .where((doc) => doc["id"] == s3)
                                .toList();
                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: filteredDocs.map((doc) {
                                var data = doc.data() as Map<String, dynamic>;
                                bool isDone = data["isDone"] ?? false;

                                return Card(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: IconButton(
                                          onPressed: () async {
                                            var newStatus = !isDone;
                                            var response =
                                                await FirebaseCrudBuyurtmalar
                                                    .updateOrder(
                                              docId: doc.id,
                                              data: {"isDone": newStatus},
                                            );
                                            if (response.code != 200) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(response
                                                        .message
                                                        .toString()),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          icon: Icon(
                                            isDone
                                                ? Icons.done_outline
                                                : Icons.done,
                                            color: isDone ? Colors.green : null,
                                          ),
                                        ),
                                        title: Text(data["mahsulot_nomi"]),
                                        subtitle: Text(data["count"]),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "КПА",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      StreamBuilder(
                        stream: collectionReference2,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            var filteredDocs = snapshot.data!.docs
                                .where((doc) => doc["id"] == s4)
                                .toList();
                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: filteredDocs.map((doc) {
                                var data = doc.data() as Map<String, dynamic>;
                                bool isDone = data["isDone"] ?? false;

                                return Card(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: IconButton(
                                          onPressed: () async {
                                            var newStatus = !isDone;
                                            var response =
                                                await FirebaseCrudBuyurtmalar
                                                    .updateOrder(
                                              docId: doc.id,
                                              data: {"isDone": newStatus},
                                            );
                                            if (response.code != 200) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(response
                                                        .message
                                                        .toString()),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          icon: Icon(
                                            isDone
                                                ? Icons.done_outline
                                                : Icons.done,
                                            color: isDone ? Colors.green : null,
                                          ),
                                        ),
                                        title: Text(data["mahsulot_nomi"]),
                                        subtitle: Text(data["count"]),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "АКП",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      StreamBuilder(
                        stream: collectionReference2,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            var filteredDocs = snapshot.data!.docs
                                .where((doc) => doc["id"] == s5)
                                .toList();
                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: filteredDocs.map((doc) {
                                var data = doc.data() as Map<String, dynamic>;
                                bool isDone = data["isDone"] ?? false;

                                return Card(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: IconButton(
                                          onPressed: () async {
                                            var newStatus = !isDone;
                                            var response =
                                                await FirebaseCrudBuyurtmalar
                                                    .updateOrder(
                                              docId: doc.id,
                                              data: {"isDone": newStatus},
                                            );
                                            if (response.code != 200) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(response
                                                        .message
                                                        .toString()),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          icon: Icon(
                                            isDone
                                                ? Icons.done_outline
                                                : Icons.done,
                                            color: isDone ? Colors.green : null,
                                          ),
                                        ),
                                        title: Text(data["mahsulot_nomi"]),
                                        subtitle: Text(data["count"]),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
