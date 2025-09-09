import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_sih/main.dart';
class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignIn();
}
Future<bool> Register(String name,String email,String password,String aadhaar) async{
  final response = await http.post(
      Uri.parse("https://farmapp-h1z4.onrender.com/"),
      headers:{"Content-Type":"application/json"},
      body: jsonEncode({"name":name,"email":email,"password":password,"aadhaar":aadhaar}));
  if(response.statusCode==200){
    return true;
  }else{
    return false;
  }
}
class _SignIn extends State<SignPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController aadhar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child:Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Container(
                    padding:EdgeInsets.only(left:15,right:15),
                    child: TextField(
                      controller:name,
                      cursorColor:Colors.black,
                      decoration:InputDecoration(
                        filled:true,
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(25),
                        ),
                        labelText: "Full Name",
                      ),
                    ),
                  ),
                  SizedBox(height:20,),

                  Container(
                    padding:EdgeInsets.only(left:15,right:15),
                    child: TextField(
                      controller:email,
                      keyboardType:TextInputType.emailAddress,
                      cursorColor:Colors.black,
                      decoration:InputDecoration(
                        filled:true,
                        border: OutlineInputBorder(

                          borderRadius:BorderRadius.circular(25),
                        ),
                        labelText: "Email",
                      ),
                    ),
                  ),
                  SizedBox(height:20,),
                  Container(
                    padding:EdgeInsets.only(left:15,right:15),
                    child: TextField(
                      controller:pass,
                      cursorColor:Colors.black,
                      decoration:InputDecoration(
                        filled:true,
                        border: OutlineInputBorder(

                          borderRadius:BorderRadius.circular(25),
                        ),
                        labelText: "Password",
                      ),
                    ),
                  ),
                  SizedBox(height:20,),
                  Container(
                    padding:EdgeInsets.only(left:15,right:15),
                    child: TextField(
                      controller:aadhar,
                      keyboardType: TextInputType.number,
                      cursorColor:Colors.black,
                      decoration:InputDecoration(
                        filled:true,
                        border: OutlineInputBorder(

                          borderRadius:BorderRadius.circular(25),
                        ),
                        labelText: "Aadhaar Number",
                      ),
                    ),
                  ),
                  SizedBox(height:20,),
                  Container(
                    width:200,
                    child:ElevatedButton(
                        onPressed: () async{
                          bool success = await Register(name.text, email.text, pass.text, aadhar.text);
                          if(bool==true){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                          }else{
                            ScaffoldMessenger(
                              child:SnackBar(content:Text("Registration Failed.."),duration:Duration(seconds:1),),
                            );
                          }
                        },
                        child: Text("SIGN IN"),
                        style:ElevatedButton.styleFrom(
                          backgroundColor:Colors.green[500],
                          foregroundColor:Colors.white,
                        )),
                  )
                ],
              ),
            ),
            Container(
              width:350,
              child:ElevatedButton(
                  onPressed: (){},
                  child: Text("<-  LOGIN"),
                  style:ElevatedButton.styleFrom(
                    backgroundColor:Colors.green[500],
                    foregroundColor:Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
