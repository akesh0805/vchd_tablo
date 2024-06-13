import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final Stream<QuerySnapshot> collectionReference2 = FirebaseCrudBuyurtmalar.readEmployee();
  final searchController = TextEditingController();
  String tmahsulot = "Tanlanmagan";
  String searchQuery = ""; // Переменная для хранения поискового запроса

  @override
  void initState() {
    super.initState();
    searchController.addListener(_updateSearchQuery); // Добавляем слушатель к контроллеру поиска
  }

  @override
  void dispose() {
    searchController.removeListener(_updateSearchQuery);
    searchController.dispose();
    super.dispose();
  }

  void _updateSearchQuery() {
    setState(() {
      searchQuery = searchController.text; // Обновляем поисковый запрос при вводе текста
    });
  }

  bool click = true;

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
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text(
                      "Maxsulot qo'shish",
                      style: TextStyle(fontSize: 25),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Maxsulot nomini kiriting ...",
                        suffix: Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: mahsulotsoni,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Bu qatorni to'ldirishingiz shart";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Maxsulot sonini kiriting..."),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var response = await FirebaseCrudBuyurtmalar.addEmployee(
                            name: tmahsulot,
                            count: mahsulotsoni.text,
                            id: widget.sehName,
                          );
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(response.message.toString()),
                              );
                            },
                          );
                        }
                      },
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Tanlangan maxsulot: $tmahsulot",
                      style: const TextStyle(fontSize: 25),
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder(
                      stream: collectionReference,
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        int selectedIndex = -1; // Инициализируем selectedIndex значением -1
                        if (snapshot.hasData) {
                          var filteredDocs = snapshot.data!.docs.where((doc) {
                            var data = doc.data() as Map<String, dynamic>;
                            var mahsulotNomi = data["mahsulot_nomi"] as String;
                            return mahsulotNomi.toLowerCase().contains(searchQuery.toLowerCase());
                          }).toList();
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: filteredDocs.length,
                            itemBuilder: (BuildContext context, int index) {
                              var e = filteredDocs[index].data() as Map<String, dynamic>;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index; // Обновляем selectedIndex при нажатии
                                    tmahsulot = e["mahsulot_nomi"];
                                  });
                                },
                                child: Card(
                                  color: selectedIndex == index ? Colors.red : null, // Устанавливаем цвет фона в зависимости от selectedIndex
                                  child: ListTile(
                                    textColor: selectedIndex == index ? Colors.red : null,
                                    title: Text(e["mahsulot_nomi"]),
                                  ),
                                ),
                              );
                            },
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
            ),
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    "Buyurtmalar Ro'yxati",
                    style: TextStyle(fontSize: 25),
                  ),
                  const Divider(),
                  StreamBuilder(
                    stream: collectionReference2,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        var filteredDocs = snapshot.data!.docs.where((doc) => doc["id"] == widget.sehName).toList();
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
                                        var response = await FirebaseCrudBuyurtmalar.updateEmployee(
                                          docId: doc.id,
                                          data: {"isDone": newStatus},
                                        );
                                        if (response.code != 200) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(response.message.toString()),
                                              );
                                            },
                                          );
                                        }
                                      },
                                      icon: Icon(
                                        isDone ? Icons.done_outline : Icons.done,
                                        color: isDone ? Colors.green : null,
                                      ),
                                    ),
                                    title: Text(data["mahsulot_nomi"]),
                                    subtitle: Text(data["count"]),
                                    trailing: IconButton(
                                      onPressed: () async {
                                        var response = await FirebaseCrudBuyurtmalar.deleteEmployee(docId: doc.id);
                                        if (response.code != 200) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(response.message.toString()),
                                              );
                                            },
                                          );
                                        }
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
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
    );
  }
}
