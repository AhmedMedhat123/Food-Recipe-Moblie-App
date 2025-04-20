import 'package:flutter/material.dart';
import 'package:food_recipe_app/pages/home.dart';
import 'package:food_recipe_app/services/auth.dart';
import 'package:food_recipe_app/pages/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Error messages for each field
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  Future<void> _register() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    // Clear previous error messages
    setState(() {
      _nameError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
    });

    // Validate form and register
    if (_validateForm(name, email, password, confirmPassword)) {
      String? result = await _authService.registerWithEmailPassword(
        name,
        email,
        password,
        confirmPassword,
      );

      if (result == null) {
        // Registration successful, navigate to login page or home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        // Handle error
        setState(() {
          _emailError = result;
        });
      }
    }
  }

  bool _validateForm(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) {
    bool isValid = true;

    if (name.isEmpty) {
      setState(() {
        _nameError = 'Name cannot be empty';
      });
      isValid = false;
    }

    if (email.isEmpty ||
        !RegExp(
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$",
        ).hasMatch(email)) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
      isValid = false;
    }

    if (password.isEmpty || password.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters long';
      });
      isValid = false;
    }

    if (confirmPassword != password) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
      });
      isValid = false;
    }

    return isValid;
  }

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
                SizedBox(height: 80),

                // Register Title
                Center(
                  child: Text(
                    "Register",
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
                      buildTextField(
                        "Name",
                        controller: _nameController,
                        errorText: _nameError,
                      ),
                      SizedBox(height: 12),
                      buildTextField(
                        "Email",
                        controller: _emailController,
                        errorText: _emailError,
                      ),
                      SizedBox(height: 12),
                      buildTextField(
                        "Password",
                        controller: _passwordController,
                        isPassword: true,
                        errorText: _passwordError,
                      ),
                      SizedBox(height: 12),
                      buildTextField(
                        "Confirm Password",
                        controller: _confirmPasswordController,
                        isPassword: true,
                        errorText: _confirmPasswordError,
                      ),
                      SizedBox(height: 34),

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
                          onPressed: _register,
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
                          Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign In",
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

  Widget buildTextField(
    String hint, {
    bool isPassword = false,
    TextEditingController? controller,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
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
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
