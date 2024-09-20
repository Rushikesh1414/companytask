import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = '';

  Future<void> _register() async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _message = 'Registration successful account status is active. Token: ${data['token']}';
      });
    } else {
      final error = json.decode(response.body);
      setState(() {
        _message = 'Registration failed: ${error['error']}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Register',style: TextStyle(
        color: Colors.white
      ),),backgroundColor: Colors.black,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 200,),
            TextField(
              controller: _emailController,
              decoration:  InputDecoration(
                hintText: 'Email',
                fillColor: Colors.grey,
                filled: true,  // Background color for text field
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded border
                ),
              ),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: _passwordController,
              decoration:  InputDecoration(
                hintText: 'Password',
                fillColor: Colors.grey,
                filled: true,  // Background color for text field
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded border
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),
            ),
            SizedBox(height: 20),
            Text(_message),

          ],
        ),
      ),
    );
  }
}
