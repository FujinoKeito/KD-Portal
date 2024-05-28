import 'package:flutter/material.dart';
import 'package:kdportal/webview.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Create a form key for validation
  String _userId = '';
  String _password = '';
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KDPortal'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Form( // Wrap the widgets in a Form for validation
            key: _formKey, // Assign the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ユーザー名を入力してください',
                    ),
                    validator: (value) { // Add validation (optional)
                      if (value == null || value.isEmpty) {
                        return 'ユーザー名を入力してください';
                      }
                      return null;
                    },
                    onSaved: (value) => setState(() => _userId = value!), // Save user ID
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            })),
                    validator: (value) { // Add validation (optional)
                      if (value == null || value.isEmpty) {
                        return 'パスワードを入力してください';
                      }
                      return null;
                    },
                    onSaved: (value) => setState(() => _password = value!), // Save password
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) { // Validate form before submit
                        _formKey.currentState!.save(); // Save form data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebView(
                              userId: _userId, // Pass _userId as an argument
                              password: _password, // Pass _password as an argument
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('ログイン'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}