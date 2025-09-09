import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_sih/SignInPage.dart';
import 'package:project_sih/main.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
Future<bool> checkUser(String email,String password) async{
  final response = await http.post(
    Uri.parse("https://farmapp-h1z4.onrender.com/"),
    headers:{"Content-Type":"application/json"},
    body:jsonEncode({"email":email,"password":password}),
  );
  if(response.statusCode==200){
    final data = jsonDecode(response.body);
    if(data["success"]==true){
      return true;
    }else{
      return false;
    }
  }else{
    return false;
  }
}
class _LoginPageState extends State<LoginPage> {
  TextEditingController _controller1=TextEditingController();
  TextEditingController _controller2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:true,
      backgroundColor:Colors.grey,
      appBar: AppBar(title:Text("Login",
        style:TextStyle(
          fontWeight:FontWeight.bold,
          fontSize:40
        ),
      ),centerTitle:true,backgroundColor:Colors.grey,),
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            BackdropFilter(
              filter:ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
              child: Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white10.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child:Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:EdgeInsets.only(left:15,right:15),
                      child: TextField(
                        controller:_controller1,
                        cursorColor:Colors.black,
                        decoration:InputDecoration(
                          filled:true,
                          border: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(25),
                          ),
                          labelText: "email",
                        ),
                      ),
                    ),
                  SizedBox(height:20,),

                    Container(
                      padding:EdgeInsets.only(left:15,right:15),
                      child: TextField(
                        controller:_controller2,
                        cursorColor:Colors.black,
                        decoration:InputDecoration(
                          filled:true,
                          border: OutlineInputBorder(

                            borderRadius:BorderRadius.circular(25),
                          ),
                          labelText: "password",
                        ),
                      ),
                    ),
                    SizedBox(height:40,),

                    Container(
                      width:320,
                      height:50,
                      child:ElevatedButton(
                          onPressed: () async{
                            String email=_controller1.text;
                            String password = _controller2.text;
                            if(email=="1" && password=="1"){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                            }
                            bool check = await checkUser(email, password);
                            if(check==true){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                            }
                          },
                          child: Text("LOGIN",style:TextStyle(fontWeight:FontWeight.bold),),
                          style:ElevatedButton.styleFrom(
                            backgroundColor:Colors.green[500],
                            foregroundColor:Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height:30,),
            Container(
              width:350,
              child:ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignPage()));
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
    );
  }
}
