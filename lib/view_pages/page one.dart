import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_features/auth_pages/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  /* getData()async{
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("users");
    QuerySnapshot querySnapshot = await collectionReference.get();
    List<QueryDocumentSnapshot> listDoc =  querySnapshot.docs;
    listDoc.forEach((element) {
     print( element.data());
     print("========================================");
    });*/
  /* getData()async{
    //.where("age",isGreaterThanOrEqualTo: 20)
    /*
    * important functions in firestore
    * orderby
    * limit
    * start At , Start after
    * where (multiple)
    * end At , End Before
    * */
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("users");
         await collectionReference.where("age",isGreaterThan: 20).where("lang",arrayContains: ["fr"]).get().then((value) {
           value.docs.forEach((element) {
             print(element.data());
             print('======================');
           });
         }

         );
  }
*/
  /*
  // real time module
  getData()async{
    FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
      event.docs.forEach((element) {
        print("${element.data()["username"]}");
        print("${element.data()["age"]}");
     print("===============================");
      });
    });
  }

*/
  /* addData()async{
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("users");
   /* collectionReference.add(
     {
       "username":"anas",
       "age":33,
       "phone": 123123,

     }*/
    collectionReference.doc("12345678").set({
      "username":"anas",
      "age":33,
      "phone": 123123,

    });


  }*/
 /* updateData() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users");
    collectionReference
        .doc("cSkcuYyFeCuC0KYO61jh")
        .set({
          "username": "dalla",
          "age": 30,
          "phone": 123123123,
        }, SetOptions(merge: true))
        .then((value) => print("success"))
        .catchError((e) {
          print('${e}');
        });
  } */
  deleteData() async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("users");

    collectionReference.doc("cSkcuYyFeCuC0KYO61jh").delete();

  }
  // ازا كنت تريد عمل عمليات علي collection داخل doc
  // CollectionReference collectionReference =
  //  FirebaseFirestore.instance.collection("users").doc(doc id).collection(collection name);
  // وكمل عادي

  @override
  void initState() {
    deleteData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignIn()));
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
        title: Text('Authentications'),
      ),
      body: Center(
        child: Text(
          "Home",
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
