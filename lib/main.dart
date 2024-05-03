import 'package:flutter/material.dart';
import 'package:vchd_tablo/screens/buyurtmalarruyxati_screen.dart';
import 'package:vchd_tablo/screens/buyurtmascreen.dart';
import 'package:vchd_tablo/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:vchd_tablo/screens/home_screen.dart';
import 'package:vchd_tablo/model/item.dart';
import 'package:vchd_tablo/screens/maxsulorqoshish_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return Sehs();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
          routes: {
            HomePage.id: (context) => const HomePage(),
            HomeScreen.id:(context) => HomeScreen(),
            OrderPage.id:(context) => OrderPage(),
            ZakazlarScreen.id:(context) => ZakazlarScreen(),
            AddProduct.id:(context) => AddProduct(),

          },
        ));
  }
}
