import 'package:flutter/material.dart';

class Seh with ChangeNotifier  {
  final String id;
  final String title;
  final String tarif;
  

  Seh({
    required this.id,
    required this.title,
    required this.tarif,
  });
}

class Sehs with ChangeNotifier {
  List<Seh> _list = [
    Seh(id: 's1', title: "G'ildirak juftliklarini ta'mirlash sexi  (КРЦ)", tarif: ""),
    Seh(id: 's2', title: "Telejkalarini ta'mirlash sexi  (ТЦ)", tarif: ""),
    Seh(id: 's3', title: "Avtobirikmalarini ta'mirlash sexi  (КПА)", tarif: ""),
    Seh(id: 's4', title: "Avtotormoz nazorat bo'limi  (АКП)", tarif: ""),
    Seh(id: 's5', title: "Vagon yig'uv sexi  (ВСЦ)", tarif: ""),
  ];

  List<Seh> get list {
    return [..._list];
  }

void addSeh(){
  notifyListeners();
}

}