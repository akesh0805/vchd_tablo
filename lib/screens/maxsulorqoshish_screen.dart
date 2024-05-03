import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});
  static const id = "addproduct";
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
            fontSize: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                  width: 600,
                  child: ExpansionTile(
                    backgroundColor: Colors.grey.shade200,
                    title: Text("Ta'mir sexini tanlang"),
                    children: [
                      ListTile(
                        title: Text('ВСЦ'),
                      ),
                      
                      ListTile(
                        title: Text('КРЦ'),
                      ),
                      
                      ListTile(
                        title: Text('ТЦ'),
                      ),
                      
                      ListTile(
                        title: Text('КПА'),
                      ),
                      ListTile(
                        title: Text('АКП'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                SizedBox(width: 600,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Maxsulot nomini kiriting")
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                ElevatedButton.icon(
                  
                  onPressed: (){}, icon: const Icon(Icons.add,color: Colors.teal,), label: Text("Saqlash",style: TextStyle(color: Colors.teal, fontSize:20 ),),
                ),
                
          ],
        ),
      ),

    );
  }
}
