// lib/pages/login.page.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyectoprogramovil/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Hardcoded username and password
  final String correctUsername = 'admin';
  final String correctPassword = 'password123';

  // Controllers to access text field input
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() {
    String enteredUsername = usernameController.text;
    String enteredPassword = passwordController.text;

    // Ensure the context is valid and within a Scaffold
    if (enteredUsername == correctUsername && enteredPassword == correctPassword) {
      // If the credentials are correct
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful!'), backgroundColor: Colors.green),
      );
    } else {
      // If the credentials are incorrect
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect username or password'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome back!',
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    SvgPicture.asset(
                      'assets/images/car-repair.svg',
                      width: 35,
                      height: 45,
                    ),
                  ],
                ),
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter Username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true, // To hide the password input
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(onPressed: _login, child: Text('Login')),

                    // Add a Divider here
                    SizedBox(height: 20),
                    Divider(
                      color: Colors.black,
                      thickness: 1, // Adjust thickness as needed
                    ),

                    // Space after the divider
                    SizedBox(height: 20),

                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/images/google.svg', // Update with your SVG file path
                        width: 24, // Adjust size as needed
                        height: 24,
                      ),
                        label: Text('Sign in with Google'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()), // Navigate to the RegisterPage
                        );
                      },
                      child: Text(
                        "Don't have an account? Register",
                        style: TextStyle(color: Colors.blue),
                    ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

