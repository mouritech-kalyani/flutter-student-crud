import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'SearchInfo.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
bool isLoading=true;
  List students=[];
  var prn;
  @override
  void initState() {
    getStudents();
    super.initState();
  }
  void getStudents ()async{
    var responce=await get(Uri.parse("https://student-management-apis.herokuapp.com/students-information"),
        headers: {"Accept":"application/json"}
    );
    print(responce);
    if(responce.body.isNotEmpty){
      setState(() {
        isLoading=false;
      });
      var converterStudents=jsonDecode(responce.body);
      setState(() {
        students=converterStudents;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.redAccent[200],
        title: Text('Student App',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
        leading:Icon(Icons.home,color: Colors.white,size: 40,),
        actions: [
          IconButton(onPressed: (){Navigator.pushNamed(context, '/register');},icon: Icon(Icons.app_registration,color: Colors.white,size: 40,))
        ],
      ),
      body: 
      isLoading ?
          Center(
            child: SpinKitRotatingCircle(color: Colors.blueAccent[400],size: 70.0,),
          )
          :
      Container(
          child:SingleChildScrollView(
            child: Column(
              children:<Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your PRN Number',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (e){setState(() {
                          prn=e;
                        });},
                      ),
                    ),
                    SizedBox(width: 40,),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchInfo(prn:prn)));
                        },
                        style: ElevatedButton.styleFrom(
                          padding:EdgeInsets.fromLTRB(20,10,20,10),
                          primary: Colors.redAccent[200]
                        ),
                        child:Text("Search",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)
                    ),
                    SizedBox(height:20),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10,0,10,0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex:1,child: Text("PRN",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                              Expanded(flex:2,child: Text("Name",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                              Expanded(flex:2,child: Text("Branch",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                              Expanded(flex:1,child: Text("Year",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),
                      ),
                    ),
       Container(
                      margin: const EdgeInsets.all(10.0),
                        
                        child: ListView.builder(
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: students.length,
                          itemBuilder: (BuildContext context, int index){
                            return Card(
                              child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Expanded(flex:1 , child: Text(students[index]["id"].toString(),style: TextStyle(fontSize: 18))),
                                      Expanded(flex:2,child: Text(students[index]["name"],style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold))),
                                      Expanded(flex:2,child: Text(students[index]["branch"],style: TextStyle(fontSize: 17))),
                                      Expanded(flex:1, child:Text(students[index]["year"],style: TextStyle(fontSize: 17))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                          }
            ),
                    
             )
              ],
        ),
          ),

          )
          );
  }
}

