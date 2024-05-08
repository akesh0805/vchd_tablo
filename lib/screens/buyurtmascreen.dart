import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vchd_tablo/services/firebase_buyurtmalar.dart';

import '../services/firebase_crud.dart';

class OrderPage extends StatefulWidget {
  final String sehName;
  const OrderPage({super.key, required this.sehName});
  static const id = "Zakazlar ekrani";

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final mahsulotsoni = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readEmployee();
  final Stream<QuerySnapshot> collectionReference2 =
      FirebaseCrudBuyurtmalar.readEmployee();
  String tmahsulot = "tanlanmagan";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Buyurtmalar Ro'yxati",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: SafeArea(
          child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const Text(
                    "Buyurtma qo'shish",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: mahsulotsoni,
                    autofocus: false,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Maxsulot sonini kiriting...")),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var response =
                            await FirebaseCrudBuyurtmalar.addEmployee(
                          name: tmahsulot,
                          count: mahsulotsoni.text,
                          id: widget.sehName,
                        );
                        if (response.code != 200) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(response.message.toString()),
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(response.message.toString()),
                                );
                              });
                        }
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Tanlangan mahsulot -- $tmahsulot",
                    style: const TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StreamBuilder(
                    stream: collectionReference,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((e) {
                            return GestureDetector(
                              onTap: () {
                                print("Select");
                                setState(() {
                                  tmahsulot = e["mahsulot_nomi"];
                                });
                              },
                              child: Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Text(e["mahsulot_nomi"]),
                                      trailing: IconButton(
                                          onPressed: () async {
                                            var response = await FirebaseCrud
                                                .deleteEmployee(docId: e.id);
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
                                          icon:
                                              const Icon(Icons.delete_rounded)),
                                    ),
                                  ],
                                ),
                              ),
                            );
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
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Buyurtmalar ro'yxati",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                const Divider(),
                StreamBuilder(
                  stream: collectionReference2,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      var filteredDocs = snapshot.data!.docs
                          .where((doc) => doc["id"] == widget.sehName)
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
          )
        ],
      )),
    );
  }
}
