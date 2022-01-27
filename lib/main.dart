import 'package:fire_features/auth_pages/sign_in.dart';
import 'package:fire_features/auth_pages/sign_up.dart';
import 'package:fire_features/fire_storage/messageApi.dart';
import 'package:fire_features/fire_storage/storage_one.dart';
import 'package:fire_features/view_pages/page%20one.dart';
import 'package:fire_features/view_pages/view_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
late bool isLogin;
Future BackgroundMessage( message)async{

    print('${message.notification!.body}');

}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(BackgroundMessage);
  var user = FirebaseAuth.instance.currentUser;
  if(user==null){
    isLogin= false;
  }else{
    isLogin= true;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLogin == false ?SignIn():MessageApi(),
      //home: isLogin == false ?SignIn():ViewPage(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

getUser()async{
  var currentUser =  FirebaseAuth.instance.currentUser;
}
initState(){
  getUser();
  super.initState();
}
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  UserCredential? userCredential;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
        title: Text('Authentications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              color: Colors.deepPurple,
              onPressed: ()async{
              userCredential = await FirebaseAuth.instance.signInAnonymously();
            },
            child: Text("signIn"),),
            SizedBox(
              height: 20,
            ),
        RaisedButton(
          color: Colors.deepPurple,
          onPressed: ()async{
            try {
               userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: "salahsaleh1015@gmail.com",
                  password: "salahsaleh1010"
              );
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
          },
        ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text("login"),
              color: Colors.deepPurple,
              onPressed: ()async{
                try {
                  userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: "salahsaleh1015@gmail.com",
                      password: "salahsaleh1010"
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
               if(userCredential!.user!.emailVerified==false){
                 User? user = FirebaseAuth.instance.currentUser;
                 await user!.sendEmailVerification();
               }


              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text("login google"),
              color: Colors.deepPurple,
              onPressed: ()async{

             UserCredential cred =  await signInWithGoogle();
             print(cred);
              },
            ),
          ],
        ),
      ),
    );
  }
}
// steps for authentication
/*
* for anonymous signIn take anonymous instance object in user credential var;
* for signUp email and password copy function create dynamic vars and call it in buttons
* for google sign in copy function create dynamic vars and call it in buttons
*
* */
