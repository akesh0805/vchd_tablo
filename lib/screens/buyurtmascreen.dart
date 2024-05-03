import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});
  static final id = "Zakazlar ekrani";

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
          Column(
            children: [
              Text(
                "Buyurtma qo'shish",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 600,
                child: ExpansionTile(
                  title: Text('Maxsulotni tanlang'),
                  children: [
                    ListTile(
                      title: Text('max 1'),
                    ),
                    ListTile(
                      title: Text('max 2'),
                    ),
                  ],
                ),
              ),
              
              SizedBox(
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Maxsulot sonini kiriting",
                    ),
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.add),
              )
            ],
          ),
          Column(
            children: [
              Text(
                "Buyurtmalar ro'yxati",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
