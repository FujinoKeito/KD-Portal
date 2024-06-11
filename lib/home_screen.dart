import 'package:flutter/material.dart';
import 'dart:async';
import 'package:kdportal/header.dart';

class FirstPage1 extends StatefulWidget {
  const FirstPage1({Key? key}) : super(key: key);

  @override
  FirstPage1State createState() => FirstPage1State();
}

class FirstPage1State extends State<FirstPage1> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [// 画像を表示
          SizedBox(height: 20),
          Text(
            'こんにちは、Flutter！',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ],
        ),
      )
    );
  }
}
