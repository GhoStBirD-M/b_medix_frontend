import 'package:flutter/material.dart';
import 'package:flutter_login/components/auth_divider.dart';
import 'package:flutter_login/components/auth_footer.dart';
import 'package:flutter_login/components/auth_header.dart';
import 'package:flutter_login/components/custom_button.dart';
import 'package:flutter_login/components/custom_text_field.dart';
import 'package:flutter_login/components/google_sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                const SizedBox(height: 20),
                const AuthHeader(),
                const SizedBox(height: 40),
                const Text(
                  'Sign In to Your Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                const GoogleSignInButton(),
                const SizedBox(height: 24),
                const AuthDivider(text: 'Or Sign In With Email'),
                const SizedBox(height: 24),
                const CustomTextField(
                  hintText: 'Your Email Or Number Phone',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  hintText: 'Your Password',
                  isPassword: true,
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
