import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
class RegisterStudent extends StatefulWidget {

  @override
  _RegisterStudentState createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {
  var name='';
  var branch='';
  var year='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[200],
        title:Text("Student Registration",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25))
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(2, 50, 2, 0),
          child: Table(
            // defaultColumnWidth: FixedColumnWidth(120.0),
            border: TableBorder.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 2),
            children: [
              TableRow( children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,15,0,0),
                    child: Column(
                        children:[Text('Student Name', style: TextStyle(fontSize: 20.0))]),
                  ),
                  Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your Name',
                ),
                onChanged: (e){
                          setState(() {
                            name=e;
                          });
                          print("name is $name");},
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),

              ]),
              TableRow( children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,15,0,0),
                  child: Column(children:[Text('Branch', style: TextStyle(fontSize: 20.0))]),
                ),
                Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your Branch',
                      ),
                      onChanged: (e){
                        setState(() {
                          branch=e;
                        });
                        print("branch is $branch");},
                      keyboardType: TextInputType.text,
                    ),
                  ],
                )

              ]),
              TableRow( children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,15,0,0),
                  child: Column(children:[Text('Year', style: TextStyle(fontSize: 20.0))]),
                ),
                Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your Year of Graduation',
                      ),
                      onChanged: (e){
                        setState(() {
                          year=e;
                          // year.toString();
                        });
                        print("branch is $year");},
                      keyboardType: TextInputType.number,
                    ),
                  ],
                )
              ]),
              TableRow( children: [
                Column(children:[]),
                Column(
                 children: [
                   ElevatedButton(onPressed: ()async{
                     if(name == '' || branch == '' || year == ''){
                       showRequiredBox(context);
                     }
                     else {
                       var responce = await post(Uri.parse(
                           "https://student-management-apis.herokuapp.com/students-information"),
                           headers: {
                             "content-type": "application/json",
                             "accept": "application/json",
                           },
                           body: jsonEncode({
                             "name": name,
                             "branch": branch,
                             "year": year
                           })
                       );
                       if (responce.body.isNotEmpty) {
                         showAlertBox(context);
                       }
                     }
                     },
                       child: Text("Register"),
                      style: ElevatedButton.styleFrom(
                       primary: Colors.redAccent[200]
                     ),
                   )
                 ],
                )
              ]),
            ],
          ),

        ),
      ),
    );
  }
  void showRequiredBox(BuildContext context){
    var alertDialog=AlertDialog(
      title: const Text("All Fields are Required"),
      content: const Text("Please fill all the fields to register"),
      actions: [
        ElevatedButton(onPressed: (){Navigator.pop(context,true);}, child: Text("Ok"))
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );
  }
}
showAlertBox(BuildContext context){
    var alertDialog=AlertDialog(
      title: const Text("Registered Successfully"),
      content: const Text("Are you want to continue"),
      actions: [
        ElevatedButton(onPressed: (){Navigator.pushNamed(context, '/');}, child: Text("Ok")),
        ElevatedButton(onPressed: ()=>{Navigator.pop(context,true)}, child: Text("Cancle"))
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );
  }