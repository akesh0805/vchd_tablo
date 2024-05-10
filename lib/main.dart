import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vchd_tablo/screens/buyurtmalarruyxati_screen.dart';
import 'package:vchd_tablo/screens/buyurtmascreen.dart';
import 'package:vchd_tablo/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:vchd_tablo/screens/home_screen.dart';
import 'package:vchd_tablo/model/item.dart';
import 'package:vchd_tablo/screens/maxsulorqoshish_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAKR2VfQ-pXiDbSzJZLfsokuW2IsdipXmc",
            appId: "1:706432269231:web:26661b673795c83d9d0d5a",
            messagingSenderId: "706432269231",
            projectId: "vchdtablo",
            storageBucket: "vchdtablo.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }
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
            HomeScreen.id: (context) => const HomeScreen(),
            OrderPage.id: (context) => const OrderPage(sehName: '',),
            ZakazlarScreen.id: (context) => const ZakazlarScreen(),
            AddProduct.id: (context) => const AddProduct(),
          },
        ));
  }
}
