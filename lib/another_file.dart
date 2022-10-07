import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primaryColor: Colors.black12,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stateless'),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
