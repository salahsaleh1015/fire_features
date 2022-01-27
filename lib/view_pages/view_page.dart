//steps of displaying data in ui
/*
 *make collection ref
 * create empty list
 * make function with loop in set state
 * use initstate
 * put in ui
 * if you need to display doc
 * make doc ref
 * create empty list
 * use initstate
 * put in ui
 *
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_features/auth_pages/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  List users = [];
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("users");
getData()async{
       var responseBody =  await collectionReference.get();
       responseBody.docs.forEach((element) {
        setState(() {
          users.add(element.data());
        });
       });
       print(users);
}
@override
  void initState() {
  getData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("display Data"),
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
          }, icon: Icon(Icons.arrow_back))
        ],
      ),
      body:ListView.builder(
          itemCount: users.length,

          itemBuilder: (context, i){
 return ListTile(
   title: Text(" user name  ${users[i]["username"]}"),
   subtitle: Text(" age  ${users[i]["age"]}"),
 )     ;

      }),
    );
  }
}


//========================================================================================
/*
* class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("display Data"),
      ),
      body: StreamBuilder(
        stream: collectionReference.snapshots(),
        builder: (context , snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemBuilder:(context , i){
                return Text("${snapshot.data!.docs[i].data()["username"]}");
              } ,
              itemCount: snapshot.data!.docs.length,
            );}else if(snapshot.hasError){
            return Text ("error");

          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
*
* */
/*FutureBuilder(future:collectionReference.get() ,builder: (context , snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemBuilder:(context , i){
              return Text("${snapshot.data!.docs[i].data()["username"]}");
            } ,
            itemCount: snapshot.data!.docs.length,
          );}else if(snapshot.hasError){
          return Text ("error");

        }
        else{
          return CircularProgressIndicator();
        }
        }
      ),*/