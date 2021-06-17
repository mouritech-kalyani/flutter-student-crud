import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class SearchInfo extends StatefulWidget {
  var prn;
  SearchInfo({required this.prn});

  @override
  _SearchInfoState createState() => _SearchInfoState(prn);
}

class _SearchInfoState extends State<SearchInfo> {
  var  prn;
  var name='';
  var branch='';
  var year='';
  var editedName='';
  var editedBranch='';
  var editedYear='';
  bool isLoading=true;
  bool isEditable=false;
  bool noData=false;
  var students={};
  _SearchInfoState(this. prn);
  @override
  void initState() {
    searchedInfo();
    super.initState();
  }
  void searchedInfo()async{
    var responce=await get(Uri.parse("https://student-management-apis.herokuapp.com/students-information/by-id/$prn"),
        headers: {"Accept":"application/json"}
    );
    var resp=responce.body;
    print('response of api is $resp');

    if(resp == 'null') {
      print('null executed');
      setState(() {
        isLoading = false;
      });
      noDataAlert(context);
    }
     else{
      print('not null executed');
      setState(() {
        isLoading=false;
      });
      var converterStudents=jsonDecode(resp);
      setState(() {
        students=converterStudents;
        name=students["name"];
        editedName=name;
        branch=students["branch"];
        editedBranch=branch;
        year=students["year"];
        editedYear=year;
      });
      print("name,branch,year is $name,$branch,$year");
      print("edited name,branch,year is $name,$branch,$year");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[200],
        title: Text('Result',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
      ),
      body: isLoading ?
      Center(
        child: SpinKitRotatingCircle(color: Colors.blueAccent[400],size: 70.0,),
      )
          :
      Container(
          margin: const EdgeInsets.fromLTRB(2, 50, 2, 0),
        child: Table(
          // defaultColumnWidth: FixedColumnWidth(120.0),
            border: TableBorder.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 2),
            children: [
              TableRow(
                  children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,15,0,0),
                  child: Column(
                      children:[Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,10),
                        child: Text('PRN Number', style: TextStyle(fontSize: 20.0))),
                      ]),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,15,0,0),
                      child: Text('$prn',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
              ]),
              TableRow( children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,15,0,0),
                  child: Column(children:[Text('Student Name', style: TextStyle(fontSize: 20.0))]),
                ),
                Column(
                  children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5,0,0,0),
                  child: TextFormField(
                  initialValue: name,
                   enabled: isEditable,
                  keyboardType: TextInputType.text,
                  onChanged: (e){setState(() {
                   editedName=e;
                  });
                   },
                  style: TextStyle(fontSize: 20.0,)
                  ),
                )
                  ],
                )
              ]),
              TableRow( children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,15,0,0),
                  child: Column(children:[Text('Branch', style: TextStyle(fontSize: 20.0))]),
                ),
                Column(
                  children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5,0,0,0),
                    child: TextFormField(
                                            initialValue: branch,
                                            enabled: isEditable,
                                            keyboardType: TextInputType.text,
                                            onChanged: (e){setState(() {
                                              editedBranch=e;
                                            });
                                            },
                        style: TextStyle(fontSize: 20.0,)
                                          ),
                  )
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5,0,0,0),
                    child: TextFormField(
                                            initialValue: year,
                                            enabled: isEditable,
                                            keyboardType: TextInputType.text,
                                            onChanged: (e){setState(() {
                                              editedYear=e;
                                            });
                                            },
                        style: TextStyle(fontSize: 20.0)
                                          ),
                  )
                  ],
                )
              ]),
              TableRow( children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,10,10,10),
                  child: ElevatedButton(onPressed: (){deleteRecord(context);}, child: Text('Delete Record')),
                ),
                Column(
                  children: [
                   Padding(
                      padding: const EdgeInsets.fromLTRB(10,10,10,10),
                      child:ElevatedButton(onPressed: (){
                        if(isEditable){
                          updateStudent(context);
                        }
                        else{
                          setState(() {
                            isEditable=true;
                          });
                        }

                      print('editable $isEditable');
                      },
                      child: isEditable ? Text('Save Record'):Text('Edit Record')),
                      ),
                  ],
                )
              ])
        ])
    )
      );
  }
  void updateStudent(BuildContext context)async{
    print('clicked delete $prn,$name,$branch,$year, $editedName,$editedBranch,$editedYear');
    if(name != editedName || branch != editedBranch || year != editedYear){
      var responce=await put(Uri.parse("https://student-management-apis.herokuapp.com/students-information"),
          headers: {
            "content-type" : "application/json",
            "accept" : "application/json",
          },
          body: jsonEncode({
            "id":prn,
            "name":editedName,
            "branch":editedBranch,
            "year":editedYear
          })
      );
      print(responce.body);
      if(responce.body.isNotEmpty){
        var alertDialog=AlertDialog(
          title: const Text("Record Updated Successfully"),
          actions: [
            ElevatedButton(onPressed: (){Navigator.pushNamed(context,'/');}, child: Text("Ok")),
          ],
        );
        showDialog(
            context: context,
            builder: (BuildContext context){
              return alertDialog;
            }
        );
      }
    }else{

      var alertDialog=AlertDialog(
        title: const Text("Changes are required to update the record"),
        actions: [
          ElevatedButton(onPressed: (){Navigator.pop(context,true);}, child: Text("Ok")),
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
  void noDataAlert(BuildContext context){
    var alertDialog=AlertDialog(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,10),
        child: SizedBox(height:400 , width: 200,child: const Text("No Data Found for this Id")),
      ),
      actions: [
        ElevatedButton(onPressed: (){Navigator.pushNamed(context,'/');}, child: Text("Ok")),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );
  }
  void deleteRecord(BuildContext context){
    var alertDialog=AlertDialog(
      title: Text("Are you Sure want to Delete Record"),
      actions: [
        ElevatedButton(onPressed: ()async{
          var responce=await delete(Uri.parse("https://student-management-apis.herokuapp.com/students-information/$prn"),
                  headers: {
                    "content-type" : "application/json",
                    "accept" : "application/json",
                  },
              );
          print("deleted $responce");
          Navigator.pushNamed(context,'/');
          }, child: Text("Ok")),
        ElevatedButton(onPressed: (){Navigator.pop(context,true);}, child: Text("Cancel")),
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

