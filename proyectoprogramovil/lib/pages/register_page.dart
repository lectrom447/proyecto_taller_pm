// lib/pages/register_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers for the text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Handle registration
  void _register() {
    String enteredEmail = emailController.text;
    String enteredUsername = usernameController.text;
    String enteredPassword = passwordController.text;
    String enteredConfirmPassword = confirmPasswordController.text;

    // Simple validation for the fields
    if (enteredEmail.isNotEmpty &&
        enteredUsername.isNotEmpty &&
        enteredPassword.isNotEmpty &&
        enteredConfirmPassword.isNotEmpty) {
      if (enteredPassword == enteredConfirmPassword) {
        // If passwords match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration successful!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // If passwords don't match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwords do not match!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // If any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
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
                      'Register',
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
                child: Column(
                  children: [
                    // Email field
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Username field
                    TextFormField(
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Password field
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter a password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true, // To hide the password input
                    ),
                    SizedBox(height: 20),

                    // Confirm Password field
                    TextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Re-enter your password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true, // To hide the password input
                    ),
                    SizedBox(height: 30),

                    // Register button
                    ElevatedButton(
                      onPressed: _register,
                      child: Text('Register'),
                    ),

                   
                    SizedBox(height: 20),
                    Divider(color: Colors.black, thickness: 1),
                    SizedBox(height: 20),

                    
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Go back to the login page
                      },
                      child: Text(
                        "Already have an account? Login",
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
