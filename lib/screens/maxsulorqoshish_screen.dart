import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firebase_crud.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});
  static const id = "addproduct";

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final mahsulotnomi = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readEmployee();
  @override
  Widget build(BuildContext context) {
    // final viewListbutton = TextButton(
    //     onPressed: () {
    //       Navigator.pushAndRemoveUntil<dynamic>(
    //         context,
    //         MaterialPageRoute<dynamic>(
    //           builder: (BuildContext context) => ListPage(),
    //         ),
    //         (route) => false, //To disable back feature set to false
    //       );
    //     },
    //     child: const Text('View List of Employee'));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          "MAXSULOT QO'SHISH",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: mahsulotnomi,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Maxsulot nomini kiriting...")),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var response = await FirebaseCrud.addEmployee(
                            name: mahsulotnomi.text,
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
                      icon: const Icon(
                        Icons.add,
                        color: Colors.teal,
                      ),
                      label: const Text(
                        "Saqlash",
                        style: TextStyle(color: Colors.teal, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: collectionReference,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.hasData);
                  return ListView(
                    children: snapshot.data!.docs.map((e) {
                      return Card(
                          child: Column(children: [
                        ListTile(
                          title: Text(e["mahsulot_nomi"]),
                          // subtitle: Container(
                          //   child: (Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: <Widget>[
                          //       Text("Position: " + e['position'],
                          //           style: const TextStyle(fontSize: 14)),
                          //       Text("Contact Number: " + e['contact_no'],
                          //           style: const TextStyle(fontSize: 12)),
                          //     ],
                          //   )),
                          // ),
                          trailing: IconButton(
                              onPressed: () async {
                                var response =
                                    await FirebaseCrud.deleteEmployee(
                                        docId: e.id);
                                if (response.code != 200) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content:
                                            Text(response.message.toString()),
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
          )
        ],
      ),
    );
  }
}
