import 'dart:convert';

import 'package:flutter/material.dart';
import 'get_response.dart';
import 'package:http/http.dart' as http;

class chatBot extends StatefulWidget {
  @override
  _ChatBot createState() => _ChatBot();
}
Future<String> Get_Response(String input) async{
    final result = await http.post(
      Uri(),
      headers:{"Content-Type":"application/json"},
      body:jsonEncode({"input":input}));
    if(result.statusCode==200){
      final data = jsonDecode(result.body);
      return data["output"];
    }else{
      return "No output";
    }
}
class _ChatBot extends State<chatBot> {
  final TextEditingController _controller = TextEditingController();
  late String ans="Enter Text";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  // void talkToAi() async{
  //   String answer = await getOpenRouterResponse(_controller.text);
  //   setState(() {
  //     ans=answer;
  //   });
  //   Store_Chat(_controller.text, ans);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:Size.fromHeight(40),
            child: AppBar(title: Text("Ai chatBot"),backgroundColor:Colors.green,)),
        body:Center(
            child: Container(
              height:double.infinity,
              width: double.infinity,
              color:Colors.grey[500],
              child:Stack(
                children: [
                  Container(
                    height:double.infinity,
                    width:500,
                    decoration:BoxDecoration(
                      color:Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child:SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(ans,style:TextStyle(color:Colors.white),)),
                  ),

                  Positioned(
                    left:0,
                    right:0,
                    bottom:1,
                    child:TextField(
                      controller:_controller,
                      cursorColor:Colors.black,
                      decoration:InputDecoration(
                        filled:true,
                        border: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(25),
                        ),
                        labelText: "Ask me anything",
                      ),
                    ),),
                ],
              ),
            )
        ),
        floatingActionButton:FloatingActionButton(onPressed:() async{
          //talkToAi();
          ans= await Get_Response(_controller.text);
        },
          child:const Icon(Icons.send),),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat
    );
  }
}
