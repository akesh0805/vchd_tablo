import 'package:flutter/material.dart';
import 'package:vchd_tablo/screens/buyurtmalarruyxati_screen.dart';
import 'package:vchd_tablo/screens/home_screen.dart';
import 'package:vchd_tablo/screens/login_page.dart';
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
        drawer: const Drawer(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "VCHD-4 QO'QON",
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Extiyot qismlariga online buyurtma berish",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Online Buyurtma",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: Colors.teal,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                      icon: const Icon(Icons.list_alt),
                      onPressed: () {
                        Navigator.pushNamed(context, HomeScreen.id);
                      },
                      label: const Text("Buyurtma berish")),
                ),
                Expanded(
                  child: ElevatedButton.icon(
                      icon: const Icon(Icons.list),
                      onPressed: () {
                        Navigator.pushNamed(context, ZakazlarScreen.id);
                      },
                      label: const Text("Buyurtmalar ro'yxati")),
                ),
                Expanded(
                  child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.pushNamed(context, LoginPage.id);
                      },
                      label: const Text("Maxsulot qo'shish")),
                ),
              ],
            ),
          ],
        ));
  }
}
