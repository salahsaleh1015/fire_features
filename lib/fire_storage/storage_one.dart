import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class StorageOne extends StatefulWidget {
  const StorageOne({Key? key}) : super(key: key);

  @override
  _StorageOneState createState() => _StorageOneState();
}

class _StorageOneState extends State<StorageOne> {
  late File file;
  var imagePicker = ImagePicker();
upLoadImage()async{
        var imagePicked = await imagePicker.getImage(source: ImageSource.camera);
        if(imagePicked != null){
      file = File(imagePicked.path);
       print(imagePicked.path);
       var nameImage = basename(imagePicked.path);
       //================================================
      var random = Random().nextInt(1000000000000000);
          var refStorage  = FirebaseStorage.instance.ref("images/$random$nameImage");
          await refStorage.putFile(file);
          var url = await refStorage.getDownloadURL();
          print("url : $url");
          //============================================
        }else{
         print("no image");
        }
}
getImages()async{
  var refImage = await FirebaseStorage.instance.ref().listAll();//او اعملها ليست بس و استخدم اوبشنز و حدد عدد معين
  refImage.items.forEach((element) {
    print(element.name);
  });
  refImage.prefixes.forEach((element) {
    print(element.name);
  });
}
var fbm = FirebaseMessaging.instance;
@override
  void initState() {
  fbm.getToken().then((token) {
    print("========token===========");
    print(token);
    print("===================");

  });
 getImages();
    super.initState();
  print("======== message body ===========");
    FirebaseMessaging.onMessage.listen((event) {
      print('${event.notification!.body}');
    });
  print("===================");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("image picker"),

      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(onPressed: ()async{
             await upLoadImage();
            },child: Text("ok"),),
          ],
        ),
      ) ,
    );
  }
}
