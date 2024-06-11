import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/parsing.dart';

void scrapingmain() {
  runApp(scraping());
}

class scraping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Scraping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _title = 'Fetching...';

  @override
  void initState() {
    super.initState();
    _fetchTitle();
  }

  Future<void> _fetchTitle() async {
    final url = 'https://appleshinja.com/blogdokushasanhe'; // スクレイピングしたいURLを指定
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final document = parseHtmlDocument(response.body);
      final titleElement = document.querySelector('title');
      setState(() {
        _title = titleElement?.text ?? 'No title found';
      });
    } else {
      setState(() {
        _title = 'Failed to load page';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Web Scraping'),
      ),
      body: Center(
        child: Text(_title),
      ),
    );
  }
}
