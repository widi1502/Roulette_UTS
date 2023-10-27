import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roulette',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 58, 106)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Roulette'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<int> controller = StreamController<int>();

  List<FortuneItem> items = [
              const FortuneItem(child: Text('Makan')),
              const FortuneItem(child: Text('Mandi')),
              const FortuneItem(child: Text('Tidur')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              controller.add(Random().nextInt(items.length));
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FortuneWheel(
            duration: const Duration(seconds: 5),
            selected: controller.stream,
            animateFirst: false,
            items: items,
            onAnimationStart: (){
              print("On Animation Start");
            },
            onAnimationEnd: (){
              print("On Animation End");
            },
            onFling: (){
              print("On Flying");
              controller.add(Random().nextInt(items.length));
            },
            onFocusItemChanged: (e){
              print(e);
            },
          ),
        ),
      ),
    );
  }
}
