import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  final ScrollController scrollController1 = ScrollController();
  bool scrollingForward1 = true;

  @override
  void initState() {
    super.initState();

    _startScrolling();
  }

  void _startScrolling() {
    Future.delayed(const Duration(seconds: 10), () {
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
                                                    .updateEmployee(
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
                                                    .updateEmployee(
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
                                                    .updateEmployee(
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
                                                    .updateEmployee(
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
                                                    .updateEmployee(
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
