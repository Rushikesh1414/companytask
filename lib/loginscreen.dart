import 'dart:convert';
import 'package:companytask/blankpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

// Function to retrieve token from shared preferences
  Future<void> retrieveAndPrintToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('auth_token');
    print('Stored Token: $storedToken'); // Printing the stored token
  }
  void login(String email, String password) async {
    try {
      Response response = await post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        String token = data['token'];
        print(token);
        print('Login successfully');

        print(data['token']);
        print('Login successfully');

        // Save token locally in shared preferences
        await saveToken(token);

        // Retrieve and print the token from shared preferences to confirm it was stored
        await retrieveAndPrintToken();
      //  await saveToken(token);
        // Navigate to a blank page and replace the current page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BlankPage()),
        );
      } else {
        // Show error message using SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed! Please try again.')),
        );
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/IMG.png',
              ),
            )),

              child: Scaffold(
                  
     backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.black,
      ),

      body: // cover the whole screen

         SingleChildScrollView(
           child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
              //  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/Frame 24.png'),
                  SizedBox(height: 15,),
                  Text("Login",style: TextStyle(
                    color: Colors.white,
                    fontWeight:FontWeight.w500,
                    fontSize: 20
                  ),),
                  SizedBox(height: 100,),
                  TextFormField(
                    controller: emailController,
                    decoration:  InputDecoration(
                      hintText: 'Email',
                      fillColor: Colors.grey,
                      filled: true,  // Background color for text field
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded border
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      fillColor: Colors.grey,

                      filled: true,  // Background color for text field
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded border
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  GestureDetector(
                    onTap: () {
                      login(emailController.text.trim(), passwordController.text.trim());
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text("Don’t have an account? Create One",style: TextStyle(
                      color: Colors.white,
                      fontWeight:FontWeight.w400,
                      fontSize: 14
                  ),),
                  const SizedBox(height: 210),
                  Text("By continuing, you are agreeing to our Terms and Conditions.",style: TextStyle(
                      color: Colors.white,
                      fontWeight:FontWeight.w400,
                      fontSize: 12
                  ),),
                ],
              ),
           
           
           
           
                  ),
         )
              )

    );
  }
}

