import 'dart:developer';
import 'package:flutter/material.dart';
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
      ..loadRequest(Uri.parse('https://pt.kobedenshi.ac.jp/portal/mobile/LoginSP.aspx'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
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
            // test
            controller.runJavaScript(
                "let username = document.getElementById('Login_UserName');"
                    "username.value = '$userId';"
                    "let userpass = document.getElementById('Login_Password');"
                    "userpass.value = '$password';"
                    "const loginbtn = document.getElementById('Login_LoginButton');"
                    "loginbtn.click();"
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
