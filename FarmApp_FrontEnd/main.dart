import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:project_sih/Ai_chat.dart';
import 'package:project_sih/FertilizerScan.dart';
import 'package:project_sih/LoginPage.dart';
import 'package:project_sih/Scanner.dart';
import 'package:project_sih/track.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // optional
      home: LoginPage(), // LoginPage as first screen
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool isListning = false;
  late stt.SpeechToText _speach;
  String text = "";
  final List<String> options = ['India','Punjab','West Bengal','Bihar'];
  String selectedOption = 'India';
  int _selectedIndex = 0;
  late PageController _pageController;
  Future<void> _listen() async {
    if (!isListning) {
      bool available = await _speach.initialize(
        onStatus: (val) => print("$val"),
        onError: (val) => print("$val"),
      );
      if (available) {
        setState(() {
          isListning = true;
          _speach.listen(
            onResult: (val) => setState(() {
              text = val.recognizedWords.toLowerCase();
            }),
          );
        });
      } else {
        isListning = false;
        _speach.stop();
        print(text);
      }
    }
  }

  Future<void> stopListen() async {
    setState(() {
      isListning = false;
      _speach.stop();
      print(text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _speach = stt.SpeechToText();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // 🔹 update selected index + animate page
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: [
              // Page 0
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            height: 200,
                            width: 170,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            child: const Center(
                                child: Text("AI",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold))),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => chatBot()));
                          },
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          child: Container(
                            height: 200,
                            width: 170,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            child: const Center(
                              child: Icon(Icons.camera_enhance, size: 50),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Scan()));
                          },
                        ),
                      ],
                    ),
                    //const SizedBox(height: 60),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            height: 200,
                            width: 170,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            child:Center(
                                child:Image.asset("assets/images/img_1.png",scale:7,),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => QrScan()));
                          },
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          child: Container(
                            height: 200,
                            width: 170,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Image.asset("assets/images/img.png",scale:7,),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Scan()));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            height: 200,
                            width: 170,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            child: const Center(
                                child: Icon(Icons.track_changes,size:50,)
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Track()));
                          },
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          child: Container(
                            height: 200,
                            width: 170,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            child: const Center(
                              child: Icon(Icons.business_center, size: 50),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Scan()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),


            // ---------- Page 1-----------------
               Stack(
                children: [
                  // Positioned(
                  //     left: 0,
                  //     right:1,
                  //     top:1,
                  //     bottom:0,
                  //     child:Container(
                  //       padding:EdgeInsets.symmetric(horizontal:12,vertical:4),
                  //       decoration:BoxDecoration(
                  //         color:Colors.blue.shade50,
                  //         borderRadius:BorderRadius.all(Radius.circular(20)),
                  //         border:Border.all(color:Colors.red)
                  //
                  //       ),
                  //       child: SizedBox(
                  //         width:160,
                  //         child: DropdownButton<String>(
                  //           value:selectedOption,
                  //           icon:Icon(Icons.arrow_drop_down),
                  //           underline:SizedBox(),
                  //           isExpanded:false,
                  //           onChanged:(String? newValue){
                  //             setState(() {
                  //               selectedOption=newValue!;
                  //             });
                  //           },
                  //           items: options.map<DropdownMenuItem<String>>((String value){
                  //             return DropdownMenuItem<String>(
                  //               value:value,
                  //               child: Text(value),
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     )
                  // ),
                  Center(child:Text("weather service"),)
                ],
              ),

              // ---------------Page 2----------------
              const Center(
                  child: Text("News Page",
                      style: TextStyle(fontSize: 28))),

              //-------------------- Page 3------------------
              const Center(
                  child: Text("Profile Page",
                      style: TextStyle(fontSize: 28))),
            ],
          ),

          // --------------MIC---------------
          Positioned(
            left: 0,
            right: 0,
            bottom: 70,
            child: AvatarGlow(
              animate: isListning,
              glowColor: Colors.blueAccent,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Long press to activate voice command")));
                },
                onLongPressStart: (_) => _listen(),
                onLongPressEnd: (_) => stopListen(),
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 35,
                  child: Icon(
                    isListning ? Icons.mic : Icons.mic_none,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // -------------------🔹 Left bottom bar----------------
          Positioned(
            left: 1,
            bottom: 1,
            child: Container(
              width: 170,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                InkWell(
                  onTap: () => _onItemTapped(0),
                  child: Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                        color: _selectedIndex == 0
                            ? Colors.lightGreenAccent
                            : Colors.white,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(30))),
                    child: const Icon(Icons.home, size: 30),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => _onItemTapped(1),
                  child: Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                        color: _selectedIndex == 1
                            ? Colors.lightGreenAccent
                            : Colors.white,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(30))),
                    child: const Icon(Icons.thunderstorm, size: 30),
                  ),
                ),
              ]),
            ),
          ),

          // -------------------🔹 Right bottom bar-----------------
          Positioned(
            right: 1,
            bottom: 1,
            child: Container(
              width: 170,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => _onItemTapped(2),
                      child: Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                            color: _selectedIndex == 2
                                ? Colors.lightGreenAccent
                                : Colors.white,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                        child: const Icon(Icons.newspaper, size: 30),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => _onItemTapped(3),
                      child: Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                            color: _selectedIndex == 3
                                ? Colors.lightGreenAccent
                                : Colors.white,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                        child: const Icon(Icons.person, size: 30),
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
