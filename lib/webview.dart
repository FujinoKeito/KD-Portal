import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:kdportal/header.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatelessWidget {
  final String userId;
  final String password;
  final WebViewController controller = WebViewController();

  WebView({super.key, required this.userId, required this.password});

  @override
  Widget build(BuildContext context) {
    debugPrint('Received text: $userId $password');

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://pt.kobedenshi.ac.jp/portal/mobile/LoginSP.aspx'))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            log('progress: $progress');
          },
          onPageStarted: (String url) {
            log('page started: $url');
          },
          onPageFinished: (String url) {
            log('page finished: $url');
            // ページロード完了後にJavaScriptを実行する
            controller.runJavaScript(
                "let custom_username = document.getElementById('Login_UserName');"
                    "if (custom_username) { custom_username.value = '$userId'; }"
                    "let custom_userpass = document.getElementById('Login_Password');"
                    "if (custom_userpass) { custom_userpass.value = '$password'; }"
                    "const custom_loginbtn = document.getElementById('Login_LoginButton');"
                    "if (custom_loginbtn) { custom_loginbtn.click(); }"
            );
          },
          onWebResourceError: (WebResourceError error) {
            log('error: $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );
    return Scaffold(
      appBar: Header(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: WebViewWidget(
                controller: controller,
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        controller.goBack();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        controller.goForward();
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        controller.reload();
                      },
                      icon: const Icon(
                        Icons.replay,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
