import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kdportal/login.dart';
import 'package:kdportal/webview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'KDPortal',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _userId;
  String? _password;

  @override
  void initState() {
    super.initState();
    _checkStoredCredentials();
  }

  Future<void> _checkStoredCredentials() async {
    final userId = await _storage.read(key: 'key');
    final password = await _storage.read(key: 'value');

    if (userId != null && password != null) {
      setState(() {
        _userId = userId;
        _password = password;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_userId != null && _password != null) {
      return Scaffold(
        body: WebView(userId: _userId!, password: _password!),
      );
    } else {
      return const Scaffold(
        body: FirstPage1(),
      );
    }
  }
}
