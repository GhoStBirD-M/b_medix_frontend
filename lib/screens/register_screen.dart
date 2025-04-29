import 'package:flutter/material.dart';
import 'package:flutter_login/components/auth_divider.dart';
import 'package:flutter_login/components/auth_footer.dart';
import 'package:flutter_login/components/auth_header.dart';
import 'package:flutter_login/components/custom_button.dart';
import 'package:flutter_login/components/custom_text_field.dart';
import 'package:flutter_login/components/google_sign_in_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Create Your Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                const CustomTextField(
                  hintText: 'First Name',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                const CustomTextField(
                  hintText: 'Last Name',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                const CustomTextField(
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                const CustomTextField(
                  hintText: 'Password',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                const CustomTextField(
                  hintText: 'Please Confirm Your Password',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Sign In',
                  onPressed: () {
                    // Handle sign in logic
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have account? ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to create account screen
                      },
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // const AuthFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
