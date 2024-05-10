import 'package:flutter/material.dart';
import 'package:vchd_tablo/screens/buyurtmalarruyxati_screen.dart';
import 'package:vchd_tablo/screens/home_screen.dart';
import 'package:vchd_tablo/screens/maxsulorqoshish_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Online Buyurtma",style: TextStyle(color: Colors.white, fontSize: 25),),
        backgroundColor: Colors.teal,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(icon: const Icon(Icons.list_alt),
                onPressed: (){
                  Navigator.pushNamed(context, HomeScreen.id);
                },  label:const Text("Buyurtma berish")),
                
              ElevatedButton.icon(icon: const Icon(Icons.list),
                onPressed: (){
                  Navigator.pushNamed(context, ZakazlarScreen.id);
                },  label:const Text("Buyurtmalar ro'yxati")),
                
              ElevatedButton.icon(icon: const Icon(Icons.add),
                onPressed: (){
                  Navigator.pushNamed(context, AddProduct.id);
                },  label:const Text("Maxsulot qo'shish")),
            ],
          ),
        ],
      )
    );
  }
}
