//steps for signUp
/*
* create your ui and create text field
* use validator and on saved functions
* make form
* create dynamic variables
* check validation
* copy function
* handle it
* call it in buttons
* */



import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fire_features/auth_pages/sign_in.dart';
import 'package:fire_features/main.dart';
import 'package:fire_features/view_pages/page%20one.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SignUp extends StatelessWidget {
   SignUp({Key? key}) : super(key: key);
GlobalKey<FormState> formkey = GlobalKey<FormState>();
var username , email , password;


   signUp()async{
     if(formkey.currentState!.validate()){
       formkey.currentState!.save();
       try {
         UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
             email: email,
             password: password
         );
         return userCredential;
       } on FirebaseAuthException catch (e) {
         if (e.code == 'weak-password') {

           print('The password provided is too weak.');
         } else if (e.code == 'email-already-in-use') {
           print('The account already exists for that email.');

         }
       } catch (e) {
         print(e);
       }
     }else{
       print("not valid");
     }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(top: 100, right: 30, left: 30, bottom: 20),
          children: [
            Row(
              children: [
                SizedBox(
                  width: 50,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Text(
                  "First create your account ",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
           Form(
             key: formkey,
             child: Column(
               children: [
                 TextFormField(

                   onSaved: (val) {
                     username = val;
                   },
                   validator: (val){
                     if(val!.length>=200){
                       return 'high length';
                     }else if(val.length<=2){
                       return 'low length';
                     }
                     return null;
                   },
                   decoration: InputDecoration(
                     focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.black)),
                     hintText: " full name",
                   ),
                 ),
                 TextFormField(
                   onSaved: (val) {
                     email = val;
                   },
                   validator: (val){
                     if(val!.length>=200){
                       return 'high length';
                     }else if(val.length<=2){
                       return 'low length';
                     }
                     return null;
                   },
                   decoration: InputDecoration(
                     focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.black)),
                     hintText: " email ",
                   ),
                 ),
                 TextFormField(
                   onSaved: (val) {
                     password = val;
                   },
                   validator: (val){
                     if(val!.length>=200){
                       return 'high length';
                     }else if(val.length<=2){
                       return 'low length';
                     }
                     return null;
                   },
                   decoration: InputDecoration(

                     focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.black)),
                     hintText: " password",
                   ),
                 ),
               ],
             ),
           ),

            SizedBox(height: 20,),
            Container(
              child: GestureDetector(
                onTap: () async{
               UserCredential response = await signUp();
               print("---------");
              if(response!=null){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PageOne()));
              }else{
                print("error");
              }
               print("---------");
                },
                child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    )),
              ),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text("already have an account"),
                GestureDetector(
                    onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                    },
                    child: Text("SignIn",style: TextStyle(color: Color(0xffDD844D),decoration: TextDecoration.underline ),)),

              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("-----------"),
                Text("skip"),
                Text("-----------"),
              ],
            ),
            SizedBox(
              height: 20,

            ),

          ],
        ),
      ),
    );
  }
}
