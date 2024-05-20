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
  final ScrollController scrollController2 = ScrollController();
  final ScrollController scrollController3 = ScrollController();
  final ScrollController scrollController4 = ScrollController();
  final ScrollController scrollController5 = ScrollController();
  bool scrollingForward1 = true;
  bool scrollingForward2 = true;
  bool scrollingForward3 = true;
  bool scrollingForward4 = true;
  bool scrollingForward5 = true;

  @override
  void initState() {
    super.initState();
    _startScrolling();
    _startScrolling2();
    _startScrolling3();
    _startScrolling4();
    _startScrolling5();
  }


  void _startScrolling() {
    Future.delayed(const Duration(seconds: 1), () {
      _scroll1();
    });
  }
  
  void _startScrolling2() {
    Future.delayed(const Duration(seconds: 1), () {
      _scroll2();
    });
  }
  void _startScrolling3() {
    Future.delayed(const Duration(seconds: 1), () {
      _scroll3();
    });
  }
  
  void _startScrolling4() {
    Future.delayed(const Duration(seconds: 1), () {
      _scroll4();
    });
  }
  
  void _startScrolling5() {
    Future.delayed(const Duration(seconds: 1), () {
      _scroll5();
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

  void _scroll2() {
    scrollController2
        .animateTo(
      scrollingForward2
          ? scrollController2.position.maxScrollExtent
          : scrollController2.position.minScrollExtent,
      duration: const Duration(seconds: 50),
      curve: Curves.linear,
    )
        .then((_) {
      scrollingForward2 = !scrollingForward2;
      _scroll2(); // Call _scroll2 again to continue the loop
    });
  }

  void _scroll3() {
    scrollController3
        .animateTo(
      scrollingForward3
          ? scrollController3.position.maxScrollExtent
          : scrollController3.position.minScrollExtent,
      duration: const Duration(seconds: 50),
      curve: Curves.linear,
    )
        .then((_) {
      scrollingForward3 = !scrollingForward3;
      _scroll3(); // Call _scroll3 again to continue the loop
    });
  }

  void _scroll4() {
    scrollController4
        .animateTo(
      scrollingForward4
          ? scrollController4.position.maxScrollExtent
          : scrollController4.position.minScrollExtent,
      duration: const Duration(seconds: 50),
      curve: Curves.linear,
    )
        .then((_) {
      scrollingForward4 = !scrollingForward4;
      _scroll4(); // Call _scroll4 again to continue the loop
    });
  }

  void _scroll5() {
    scrollController5
        .animateTo(
      scrollingForward5
          ? scrollController5.position.maxScrollExtent
          : scrollController5.position.minScrollExtent,
      duration: const Duration(seconds: 50),
      curve: Curves.linear,
    )
        .then((_) {
      scrollingForward5 = !scrollingForward5;
      _scroll5(); // Call _scroll5 again to continue the loop
    });
  }

  @override
  void dispose() {
    scrollController1.dispose();
    scrollController2.dispose();
    scrollController3.dispose();
    scrollController4.dispose();
    scrollController5.dispose();

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
            child: Column(
              children: [
                const Text(
                  "ВСЦ",
                  style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                ),
                Container(
                  color: Colors.teal,
                  height: 5,
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
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: filteredDocs.map((e) {
                                return Card(
                                    child: Column(children: [
                                  ListTile(
                                    title: Text(
                                      e["mahsulot_nomi"]
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    subtitle: Text(
                                      e["count"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () async {
                                          var response =
                                              await FirebaseCrudBuyurtmalar
                                                  .deleteEmployee(docId: e.id);
                                          if (response.code != 200) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text(response.message
                                                      .toString()),
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
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "КРЦ",
                  style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                ),
                Container(
                  color: Colors.teal,
                  height: 5,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    controller: scrollController2,
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
                              children: filteredDocs.map((e) {
                                return Card(
                                    child: Column(children: [
                                  ListTile(
                                    title: Text(
                                      e["mahsulot_nomi"]
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    subtitle: Text(
                                      e["count"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () async {
                                          var response =
                                              await FirebaseCrudBuyurtmalar
                                                  .deleteEmployee(docId: e.id);
                                          if (response.code != 200) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text(response.message
                                                      .toString()),
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
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "ТЦ",
                  style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                ),
                Container(
                  color: Colors.teal,
                  height: 5,
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController3,
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
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: filteredDocs.map((e) {
                                return Card(
                                    child: Column(children: [
                                  ListTile(
                                    title: Text(
                                      e["mahsulot_nomi"]
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    subtitle: Text(
                                      e["count"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () async {
                                          var response =
                                              await FirebaseCrudBuyurtmalar
                                                  .deleteEmployee(docId: e.id);
                                          if (response.code != 200) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text(response.message
                                                      .toString()),
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
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "КПА",
                  style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                ),
                Container(
                  color: Colors.teal,
                  height: 5,
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController4,
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
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: filteredDocs.map((e) {
                                return Card(
                                    child: Column(children: [
                                  ListTile(
                                    title: Text(
                                      e["mahsulot_nomi"]
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    subtitle: Text(
                                      e["count"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () async {
                                          var response =
                                              await FirebaseCrudBuyurtmalar
                                                  .deleteEmployee(docId: e.id);
                                          if (response.code != 200) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text(response.message
                                                      .toString()),
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
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "АКП",
                  style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                ),
                Container(
                  color: Colors.teal,
                  height: 5,
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController5,
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
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: filteredDocs.map((e) {
                                return Card(
                                    child: Column(children: [
                                  ListTile(
                                    title: Text(
                                      e["mahsulot_nomi"]
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    subtitle: Text(
                                      e["count"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () async {
                                          var response =
                                              await FirebaseCrudBuyurtmalar
                                                  .deleteEmployee(docId: e.id);
                                          if (response.code != 200) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text(response.message
                                                      .toString()),
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
          ),
        ],
      ),
    );
  }
}
