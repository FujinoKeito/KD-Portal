import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:kdportal/webview.dart';

class FirstPage1 extends StatefulWidget {
  const FirstPage1({Key? key}) : super(key: key);

  @override
  FirstPage1State createState() => FirstPage1State();
}

class FirstPage1State extends State<FirstPage1> {
  // flutter_secure_storageを使用するためにFlutterSecureStorageを生成する
  final _storage = const FlutterSecureStorage();

  final _keyTextController = TextEditingController();
  final _valueTextController = TextEditingController();

  String _UserName = '';
  String _Password = '';

  @override
  void initState() {
    super.initState();
    // アプリを起動した時に保存したデータがあれば読み込み表示する
    _readData();
  }

  Future<void> _readData() async {
    // データを読み込む
    final key = await _storage.read(key: 'key');
    final value = await _storage.read(key: 'value');
    setState(() {
      _UserName = key ?? '';
      _Password = value ?? '';
    });
  }


  // データを削除して、再描画する
  Future<void> _deleteData() async {
    await _storage.delete(key: 'key');
    await _storage.delete(key: 'value');
    _keyTextController.text = '';
    _valueTextController.text = '';
    _readData();
  }

  // データを保存する
  Future<void> _saveData() async {
    final String key = _keyTextController.text;
    final String value = _valueTextController.text;

    await _storage.write(key: 'key', value: key);
    await _storage.write(key: 'value', value: value);
    _keyTextController.text = '';
    _valueTextController.text = '';
    _readData();

    Navigator.push( // WebViewに値を渡す
      context,
      MaterialPageRoute(
        builder: (context) => WebView(
          userId: key,
          password: value,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text('何かテキスト'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: _keyTextController,
            decoration: const InputDecoration(labelText: 'ユーザー名'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: _valueTextController,
            decoration: const InputDecoration(labelText: 'パスワード'),
          ),
        ),
        ElevatedButton(
          onPressed: _saveData,
          child: const Text('ログイン'),
        ),
        Expanded(
          child: Center(
            child: Text(
              'ユーザー名: $_UserName\nパスワード: $_Password',
              style: const TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: TextButton(
            onPressed: _deleteData,
            child: const Text(
              'ユーザー名とパスワードを削除',
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
          ),
        )
      ],
    ),
  );
}
