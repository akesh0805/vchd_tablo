import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vchd_tablo/model/item.dart';
import 'package:vchd_tablo/screens/buyurtmascreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const id = 'home-screen';

  @override
  Widget build(BuildContext context) {
    final sehData = Provider.of<Sehs>(context);

    final sehlar = sehData.list;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text(
          "Smart VChD-4",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ))
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 2 / 1,
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          final seh = sehData.list[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderPage(
                    sehName: seh.id,
                  ),
                ),
              );
            },
            child: GridTile(
              header: const Text(
                "Qo'qon Vagon Deposi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              footer: GridTileBar(
                leading: const Icon(
                  Icons.construction,
                  size: 30,
                ),
                title: Text(
                  sehlar[index].title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.black54,
              ),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.7),
                        blurRadius: 3,
                        spreadRadius: 4,
                        // offset: Offset(0, 8),
                        blurStyle: BlurStyle.normal,
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 55),
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
            ),
          );
        },
        itemCount: sehlar.length,
      ),
    );
  }
}
