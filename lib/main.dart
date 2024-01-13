import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      primaryColorDark: Colors.black,
    ),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController textController = TextEditingController();
  bool firstUse = true;
  int value = 1;
  bool lockedButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lucky Ball'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  'Ask a question to the lucky ball 🎱: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ]),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Your Question',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextButton(
                            onPressed: () {
                              textController.clear();
                            },
                            child: const Icon(
                              Icons.backspace_outlined,
                              size: 30,
                            )),
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: lockedButton
                    ? null
                    : () {
                        if (textController.text.isNotEmpty) {
                          callMagicBall();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter a question',
                                      style: TextStyle(fontSize: 20)),
                                  duration: Duration(seconds: 2)));
                        }
                      },
                child: const Text('Ask'),
              ),
              const SizedBox(
                height: 8,
              ),
              Text('The answer is: ', style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                  visible: !firstUse,
                  child: Image(
                    image: AssetImage('assets/images/ball${value}.png'),
                  ))
            ],
          ),
        ));
  }

  void callMagicBall() async {
    setState(() {
      firstUse = false;
      value = Random().nextInt(5) + 1;
      lockedButton = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      textController.clear();
      lockedButton = false;
    });
  }
}
