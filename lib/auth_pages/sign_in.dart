//steps for signUp
/*
* create your ui and create text field
* use validator and on saved functions
* make form
* create dynamic variables
* check validation
* copy function
* handle it
* call it in
* save user data
* create bool var
* use firebase auth current user
* if statement
* make ternary operator
* create sign out from hoe page
* */






import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fire_features/auth_pages/sign_up.dart';
import 'package:fire_features/fire_storage/storage_one.dart';
import 'package:fire_features/view_pages/page%20one.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
class SignIn extends StatelessWidget {
   SignIn({Key? key}) : super(key: key);
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var email , password;
  signIn()async{
    if(formkey.currentState!.validate()){
      formkey.currentState!.save();
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email:email,
          password: password
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
       // AwesomeDialog(
         // title: "error",
          //body: Text("user-not-found"), context:context,
       // );
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
key: formkey,
          child: ListView(
            padding: EdgeInsets.only(top: 100, right: 30, left: 30, bottom: 20),
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "Sign In",
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
                    "Enter your email and password",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
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
                  hintText: " email",
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Spacer(),
                  Text(
                    "forget me password?",
                    style: TextStyle(color: Color(0xffDD844D)),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: GestureDetector(
onTap: ()async{
    var result = await signIn();
    if(result!=null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>StorageOne()));
    }
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
                  Text("Don\,t Have an account ?"),
                  GestureDetector(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                 },
                      child: Text("SignUp",style: TextStyle(color: Color(0xffDD844D),decoration: TextDecoration.underline ),)),

                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("-----------"),
                  Text("SignIn with"),
                  Text("-----------"),
                ],
              ),
              SizedBox(
                height: 20,

              ),

            ],
          ),
        ),
      ),
    ) ;
  }
}
