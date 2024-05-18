import 'dart:async';

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
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;
  bool _scrollToBottom = true;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_scrollToBottom) {
        _scrollDown();
      } else {
        _scrollUp();
      }
      _scrollToBottom = !_scrollToBottom;
    });
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void _scrollUp() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

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
            child: ListView(
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
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                         controller: _scrollController,
                        children: filteredDocs.map((e) {
                          return Card(
                              child: Column(children: [
                            ListTile(
                              title: Text(
                                e["mahsulot_nomi"].toString().toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              subtitle: Text(
                                e["count"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
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
            child: ListView(
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
                        physics: const NeverScrollableScrollPhysics(),
                        children: filteredDocs.map((e) {
                          return Card(
                              child: Column(children: [
                            ListTile(
                              title: Text(
                                e["mahsulot_nomi"].toString().toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              subtitle: Text(
                                e["count"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
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
            child: ListView(
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
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: filteredDocs.map((e) {
                          return Card(
                              child: Column(children: [
                            ListTile(
                              title: Text(
                                e["mahsulot_nomi"].toString().toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              subtitle: Text(
                                e["count"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
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
            child: ListView(
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
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: filteredDocs.map((e) {
                          return Card(
                              child: Column(children: [
                            ListTile(
                              title: Text(
                                e["mahsulot_nomi"].toString().toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              subtitle: Text(
                                e["count"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
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
            child: ListView(
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
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: filteredDocs.map((e) {
                          return Card(
                              child: Column(children: [
                            ListTile(
                              title: Text(
                                e["mahsulot_nomi"].toString().toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              subtitle: Text(
                                e["count"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
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
