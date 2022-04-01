import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/model.dart';


void main() async{
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Mitul(),
  ));
}

class Mitul extends StatefulWidget {
  const Mitul({Key? key}) : super(key: key);

  @override
  _MitulState createState() => _MitulState();
}

class _MitulState extends State<Mitul> {
  late Future<List<Post>> fetchData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(()  {

      fetchData = fetchPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data from QR_API"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchPost(),
        builder: (context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              List<Post> data= snapshot.data;
              return ListView.builder(
                padding: EdgeInsets.all(10),
                  itemCount: data.length,
                  itemBuilder: (context,i){
                    return Card(
                      elevation: 3,
                      color: Colors.blue,
                      child: ListTile(
                        leading: Text("${data[i].message}",style: TextStyle(color: Colors.white),),
                        // title: Text("${data[i].title}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                        // subtitle: Text("${data[i].body}",style: TextStyle(color: Colors.white)),
                        // trailing: Text("${data[i].userID}",style: TextStyle(color: Colors.white)),
                      ),
                    );
                  }
                  );
            }else if(snapshot.hasError){
              print(snapshot.error); Text("ERROR : ${snapshot.error}", style: TextStyle(fontSize: 30,color: Colors.red),);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }


Future<List<Post>> fetchPost() async{
    String  API = "http://65.2.127.123:3004/check/100001";
    http.Response res= await http.get(Uri.parse(API),
      );
    List data= jsonDecode(res.body);
    if(res.statusCode == 200){
      // Post p = Post.fromJson(data);
      // return p;
      List<Post> res = data.map((e) => Post.fromJson(e)).toList();
      print(res);
      return res;
    }
    return [Post(message: "")];

  }

}
