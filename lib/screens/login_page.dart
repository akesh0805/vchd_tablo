import 'package:flutter/material.dart';
import 'package:vchd_tablo/screens/maxsulorqoshish_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static final id = "loginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _parolController = TextEditingController();
  String _errorxabar = '';

  void _login() {
    String login = _loginController.text;
    String parol = _parolController.text;

    if (login == 'admin689' && parol == 'vchd4689') {
      setState(() {
        Navigator.of(context).pushNamed(AddProduct.id);
      });
    } else {
      setState(() {
        _errorxabar = 'Login yoki parol xato !';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          "MAXSULOT QO'SHISH",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Maxsulotlarni faqatgina admin qo'shishi yoki o'chirishi mumkin !",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Iltimos noto'gri login yoki parol kiritmang !",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _loginController,
                decoration: InputDecoration(
                    labelText: "Login",
                    suffix: Icon(Icons.login),
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _parolController,
                decoration: InputDecoration(
                    labelText: "Parol",
                    suffix: Icon(Icons.password),
                    border: OutlineInputBorder()),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: (_login) ,
              child: Text("KIRISH"),
            ),
            SizedBox(
              height: 100,
            ),
            RichText(
              text: TextSpan(
                  children: [
                    WidgetSpan(
                        child: Icon(
                      Icons.contacts,
                      color: Colors.green,
                    ))
                  ],
                  text: "Aloqa uchun konaktlar   ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.people,
                        color: Colors.green,
                      ),
                    ),
                    WidgetSpan(
                        child: Text("     +998-91-192-3567",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)))
                  ],
                  text: "ZamVCHDr:   ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                  children: [
                    WidgetSpan(
                        child: Icon(
                      Icons.people,
                      color: Colors.green,
                    )),
                    WidgetSpan(
                        child: Text("     +998-99-313-0805",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)))
                  ],
                  text: "VCHDT:   ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
