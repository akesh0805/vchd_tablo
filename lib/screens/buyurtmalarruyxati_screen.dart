import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../services/firebase_buyurtmalar.dart';

class ZakazlarScreen extends StatefulWidget {
  const ZakazlarScreen({super.key});
  static const id = "Zakazlarruyxati";

  @override
  State<ZakazlarScreen> createState() => _ZakazlarScreenState();
}

class _ZakazlarScreenState extends State<ZakazlarScreen> {
  final Stream<QuerySnapshot> collectionReference2 =
      FirebaseCrudBuyurtmalar.readEmployee();
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('dd.MM.yyyy').format(now);
    String text = "KUNGI BUYURTMALAR RO'YXATI";
    String appbar = '$formattedDate $text';
    String s1 = "s1";
    String s2 = "s2";
    String s3 = "s3";
    String s4 = "s4";
    String s5 = "s5";
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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 35),
        //     child: Text(formattedDate, style: TextStyle(color: Colors.white, fontSize: 30),),
        //   )
        // ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              children: [
                const Text(
                  "ВСЦ",
                  style: TextStyle(fontSize: 35),
                ),
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
                        children: filteredDocs.map((e) {
                          return Card(
                              child: Column(children: [
                            ListTile(
                              title: Text(e["mahsulot_nomi"]),
                              subtitle: Text(e["count"]),
                              trailing: IconButton(
                                  onPressed: () async {
                                    var response = await FirebaseCrudBuyurtmalar
                                        .deleteEmployee(docId: e.id);
                                    if (response.code != 200) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                                response.message.toString()),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.delete_rounded)),
                            ),
                          ]));
                        }).toList(),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "КРЦ",
                  style: TextStyle(fontSize: 35),
                ),
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
                        children: filteredDocs.map((e) {
                          return Card(
                              child: Column(children: [
                            ListTile(
                              title: Text(e["mahsulot_nomi"]),
                              subtitle: Text(e["count"]),
                              trailing: IconButton(
                                  onPressed: () async {
                                    var response = await FirebaseCrudBuyurtmalar
                                        .deleteEmployee(docId: e.id);
                                    if (response.code != 200) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                                response.message.toString()),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.delete_rounded)),
                            ),
                          ]));
                        }).toList(),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "ТЦ",
                  style: TextStyle(fontSize: 35),
                ),
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
                        children: filteredDocs.map((e) {
                          return Card(
                              child: Column(children: [
                            ListTile(
                              title: Text(e["mahsulot_nomi"]),
                              subtitle: Text(e["count"]),
                              trailing: IconButton(
                                  onPressed: () async {
                                    var response = await FirebaseCrudBuyurtmalar
                                        .deleteEmployee(docId: e.id);
                                    if (response.code != 200) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                                response.message.toString()),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.delete_rounded)),
                            ),
                          ]));
                        }).toList(),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "КПА",
                  style: TextStyle(fontSize: 35),
                ),
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
                        children: filteredDocs.map((e) {
                          return Card(
                              child: Column(children: [
                            ListTile(
                              title: Text(e["mahsulot_nomi"]),
                              subtitle: Text(e["count"]),
                              trailing: IconButton(
                                  onPressed: () async {
                                    var response = await FirebaseCrudBuyurtmalar
                                        .deleteEmployee(docId: e.id);
                                    if (response.code != 200) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                                response.message.toString()),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.delete_rounded)),
                            ),
                          ]));
                        }).toList(),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "АКП",
                  style: TextStyle(fontSize: 35),
                ),
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
                        children: filteredDocs.map((e) {
                          return Card(
                              child: Column(children: [
                            ListTile(
                              title: Text(e["mahsulot_nomi"]),
                              subtitle: Text(e["count"]),
                              trailing: IconButton(
                                  onPressed: () async {
                                    var response = await FirebaseCrudBuyurtmalar
                                        .deleteEmployee(docId: e.id);
                                    if (response.code != 200) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(
                                                response.message.toString()),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.delete_rounded)),
                            ),
                          ]));
                        }).toList(),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
