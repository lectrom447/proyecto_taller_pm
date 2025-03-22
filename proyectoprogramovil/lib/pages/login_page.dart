// lib/pages/login.page.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proyectoprogramovil/components/custom_button.dart';
import 'package:proyectoprogramovil/helpers/validators.dart';
import 'package:proyectoprogramovil/services/auth_service.dart';
// import 'package:proyectoprogramovil/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Hardcoded username and password
  final String correctUsername = 'admin';
  final String correctPassword = 'password123';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers to access text field input
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  bool _isLoading = false;
  final AuthService _authService = AuthService();


  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    // String enteredUsername = usernameController.text;
    // String enteredPassword = passwordController.text;

    // // Ensure the context is valid and within a Scaffold
    // if (enteredUsername == correctUsername &&
    //     enteredPassword == correctPassword) {
    //   // If the credentials are correct
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Login successful!'),
    //       backgroundColor: Colors.green,
    //     ),
    //   );
    // } else {
    //   // If the credentials are incorrect
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Incorrect username or password'),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailInputController.text,
        password: _passwordInputController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
        _passwordInputController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect email or password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    UserCredential? userCredential = await _authService.signInWithGoogle();

    setState(() {
      _isLoading = false;
    });

    if (userCredential == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google Sign-In failed'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google Sign-In successful'),
          backgroundColor: Colors.green,
        ),
      );
      // Navigate to another page after successful sign-in
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
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
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
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
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      enabled: !_isLoading,
                      controller: _emailInputController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter Username',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator:
                          (value) =>
                              (!Validators.isValidEmail(value!))
                                  ? 'Invalid Email'
                                  : null,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      enabled: !_isLoading,
                      controller: _passwordInputController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator:
                          (value) =>
                              (value == null || value.isEmpty)
                                  ? 'Enter your password.'
                                  : null,
                      obscureText: true, // To hide the password input
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: 'Login',
                        onPressed: _login,
                        isLoading: _isLoading,
                      ),
                    ),

                    // Add a Divider here
                    SizedBox(height: 20),
                    Divider(
                      color: Colors.black,
                      thickness: 1, // Adjust thickness as needed
                    ),

                    // Space after the divider
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _signInWithGoogle,
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
                        Navigator.of(
                          context,
                        ).pushReplacementNamed('auth/register');
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => RegisterPage(),
                        //   ), // Navigate to the RegisterPage
                        // );
                      },
                      child: Text(
                        "Don't have an account? Register",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
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
