import 'package:flutter/material.dart';
import 'package:food_recipe_app/pages/register.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F1),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Arrow
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(0xFF81230A),
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 100),

                // Register Title
                Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF81230A),
                    ),
                  ),
                ),
                SizedBox(height: 50),

                // Input Fields
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextField("Email"),
                      SizedBox(height: 12),
                      buildTextField("Password", isPassword: true),
                      SizedBox(height: 12),

                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF6B2C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            // Register action
                          },
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Sign In Text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xFFFF6B2C),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hint, {bool isPassword = false}) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
