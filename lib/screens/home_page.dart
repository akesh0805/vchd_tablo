import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vchd_tablo/screens/buyurtmalarruyxati_screen.dart';
import 'package:vchd_tablo/screens/home_screen.dart';
import 'package:vchd_tablo/screens/login_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 500,
                        height: 300,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                "https://sc04.alicdn.com/kf/H3f820b4afd344461988f8a78eb433185E/229626809/H3f820b4afd344461988f8a78eb433185E.png",
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Colors.grey.shade700, width: 2),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                          icon: const Icon(Icons.list_alt),
                          onPressed: () {
                            Navigator.pushNamed(context, HomeScreen.id);
                          },
                          label: const Text("Buyurtma berish")),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 500,
                        height: 300,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                  "https://static.tildacdn.com/tild3963-3330-4462-a430-643431333965/photo.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Colors.grey.shade700, width: 2),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                          icon: const Icon(Icons.list),
                          onPressed: () {
                            Navigator.pushNamed(context, ZakazlarScreen.id);
                          },
                          label: const Text("Buyurtmalar ro'yxati")),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 500,
                        height: 300,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                  "https://259506.selcdn.ru/sites-static/site812817/321cc7a3-9130-4b20-9052-b45a3393a06e/321cc7a3-9130-4b20-9052-b45a3393a06e-6378475.jpeg"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Colors.grey.shade700, width: 2),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Navigator.pushNamed(context, LoginPage.id);
                          },
                          label: const Text("Maxsulot qo'shish")),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    pause: const Duration(seconds: 3),
                    animatedTexts: [
                      TypewriterAnimatedText("VCHD - 4 ",
                          speed: const Duration(milliseconds: 180)),
                      TypewriterAnimatedText("Qo'qon vagon deposi",
                          speed: const Duration(milliseconds: 180)),
                      TypewriterAnimatedText(
                          "Ta'mir sexlaridan ehtiyot qismlar uchun online buyurtma olish dasturi",
                          speed: const Duration(milliseconds: 180)),
                      TypewriterAnimatedText(
                          "Ushbu dastur sinov tariqasida ishlamoqda",
                          speed: const Duration(milliseconds: 180)),
                    ],
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
