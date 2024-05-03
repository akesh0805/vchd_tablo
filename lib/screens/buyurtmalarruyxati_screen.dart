import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ZakazlarScreen extends StatelessWidget {
  const ZakazlarScreen({super.key});
  static const id = "Zakazlarruyxati";

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('dd.MM.yyyy').format(now);
    String text = "KUNGI BUYURTMALAR RO'YXATI";
    String appbar = '$formattedDate $text';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          appbar,
          style: TextStyle(
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
          Text(
            "ВСЦ",
            style: TextStyle(fontSize: 35),
          ),
          Text(
            "КРЦ",
            style: TextStyle(fontSize: 35),
          ),
          Text(
            "ТЦ",
            style: TextStyle(fontSize: 35),
          ),
          Text(
            "КПА",
            style: TextStyle(fontSize: 35),
          ),
          Text(
            "АКП",
            style: TextStyle(fontSize: 35),
          ),
        ],
      ),
    );
  }
}
