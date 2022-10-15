import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stop Watch App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterDownApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CounterDownApp extends StatefulWidget {
  const CounterDownApp({Key? key}) : super(key: key);

  @override
  State<CounterDownApp> createState() => _CounterDownAppState();
}

class _CounterDownAppState extends State<CounterDownApp> {
  Timer? repeatedFunction;

  Duration duration = const Duration(seconds: 0);

  startTimer() {
    repeatedFunction = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        int newSeconds = duration.inSeconds + 1;
        duration = Duration(seconds: newSeconds);
      });
    });
  }

  bool isRuning =
      false; //boolean variable , i'll use it to confirm some conditions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 40, 43),
      appBar: AppBar(
        title: const Text(
          "Stop Watch App",
          style: TextStyle(
              fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 22),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      duration.inHours.toString().padLeft(2, "0"),
                      style: const TextStyle(fontSize: 77),
                    ),
                  ),
                  const Text(
                    "Hours",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 22),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      duration.inMinutes
                          .remainder(
                              60) // remainder mean that ur limit until 60 [cant be more than 60]
                          .toString()
                          .padLeft(2, "0"),
                      style: const TextStyle(fontSize: 77),
                    ),
                  ),
                  const Text(
                    "Minutes",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 22),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      duration.inSeconds
                          .remainder(
                              60) // remainder mean that ur limit until 60 [cant be more than 60]
                          .toString()
                          .padLeft(2, "0"),
                      style: const TextStyle(fontSize: 77),
                    ),
                  ),
                  const Text(
                    "Seconds",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 55,
          ),
          isRuning // When i press "start timer" , its button will disapeared and another 2 buttons "stop , cancel" will appear , this will happen using "isRuning" bool variable
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (repeatedFunction!.isActive) {
                          setState(() {
                            repeatedFunction!.cancel();
                          });
                        } else {
                          startTimer();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 55, 120, 197)),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                      child: Text(
                        (repeatedFunction!.isActive) ? "Stop" : "Resume",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        repeatedFunction!.cancel();
                        setState(() {
                          duration = const Duration(seconds: 0);
                          isRuning = false;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 55, 120, 197)),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    startTimer();
                    setState(() {
                      isRuning = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 55, 120, 197)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(14)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9))),
                  ),
                  child: const Text(
                    "Start Timer",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
        ],
      ),
    );
  }
}
