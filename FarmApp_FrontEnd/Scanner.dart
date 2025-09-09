import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:project_sih/main.dart';


class Scan extends StatelessWidget {
  const Scan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:ScanPage(),
    );
  }
}

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});
  @override
  State<ScanPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ScanPage> {
  XFile? pickedImage;
  late String myText;
  bool isScanning=false;
  final ImagePicker imagePicker =ImagePicker();
  getImage(ImageSource source) async{
    XFile? result = await imagePicker.pickImage(source: source);
    if(result!=null){
      setState(() {
        pickedImage=result;
      });
      performTextRecognition();
    }
  }
  performTextRecognition() async{
    setState(() {
      isScanning=true;
    });
    try{
      final inputImage=InputImage.fromFilePath(pickedImage!.path);
      final textRecognizer = GoogleMlKit.vision.textRecognizer();
      final recognizedText=await textRecognizer.processImage(inputImage);
      setState(() {
        myText=(recognizedText.text==null?"":recognizedText.text);
        isScanning=false;
      });
      textRecognizer.close();
    }catch(e){
      ScaffoldMessenger(
        child:SnackBar(content:Text("Error:$e")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme:IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text("Scan Crops",style:TextStyle(color: Colors.white),),
        ),
        body: Container(
          color:Colors.black,
          child: Center(
            child: ListView(
              children: [
                pickedImage==null?
                Padding(padding: const EdgeInsets.symmetric(horizontal:30,vertical:30),child:Container(height:400,width:300,decoration:BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(20)),color:Colors.grey[300]),child:Center(child:Text("No image detected"),),),):
                Center(child:Image.file(File(pickedImage!.path),height: 400,)),
                SizedBox(height:20,),
                Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){getImage(ImageSource.gallery);}, child:Text("Gallery")),
                      SizedBox(width:60,),
                      ElevatedButton(onPressed: (){getImage(ImageSource.camera);}, child:Text("Camera")),]
                ),


                SizedBox(height: 30,),
                isScanning?
                Padding(
                  padding:const EdgeInsets.only(top:60),
                  child: Center(child:SpinKitThreeBounce(color:Colors.black),),
                ):
                Center(
                    child:Container(
                      width:300,
                      child:ElevatedButton(onPressed: (){
                        pickedImage==null?ScaffoldMessenger(child:SnackBar(content:Text("Please select a image",style:TextStyle(color:Colors.white),),duration:Duration(seconds: 1),)):
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                      }, child:Text("ADD",style:TextStyle(color: Colors.pink),)),
                    )
                )
              ],
            ),
          ),
        )

    );
  }
}
