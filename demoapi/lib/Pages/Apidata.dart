import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Apidata extends StatefulWidget {
  const Apidata({Key? key}) : super(key: key);

  @override
  _ApidataState createState() => _ApidataState();
}

class _ApidataState extends State<Apidata> {
  List decodedData=[];
  int id=38;
  // String name='viya';
  // String branch="food";
  // String year="second year";

  void getData() async {
    //Get API
    // var responce=await get(Uri.parse("https://student-management-apis.herokuapp.com/students-information"),
    // headers: {"Accept":"application/json"}
    // );

    //Post API
    // var responce=await post(Uri.parse("https://student-management-apis.herokuapp.com/students-information"),
    //     headers: {
    //       "content-type" : "application/json",
    //       "accept" : "application/json",
    //     },
    //     body: jsonEncode({
    //       "name":name,
    //       "branch":branch,
    //       "year":year
    //     })
    //     );

    //Put API
    // var responce=await put(Uri.parse("https://student-management-apis.herokuapp.com/students-information"),
    //         headers: {
    //           "content-type" : "application/json",
    //           "accept" : "application/json",
    //         },
    //         body: jsonEncode({
    //           "id":38,
    //           "name":name,
    //           "branch":branch,
    //           "year":year
    //         })
    //         );
    //        print(responce.body);

    //Delete API
    // var responce=await delete(Uri.parse("https://student-management-apis.herokuapp.com/students-information/$id"),
    //     headers: {
    //       "content-type" : "application/json",
    //       "accept" : "application/json",
    //     },
    // );
    // print(responce.body);

    //For Get APi show data on Page
    // decodedData=jsonDecode(responce.body);
    // print(decodedData);
  }

  @override
  void initState(){
    super.initState();
    getData();
    print('get all data');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Api Data')),
      body: Container(
child: Text('hi'),
      ),
        // child:ListView.builder(
        //     itemCount: decodedData.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Text(decodedData[index]['name']);
        //     }),


    );
  }
}

