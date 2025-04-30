import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/app_pages.dart';
import '../widgets/auth/auth_divider.dart';
import '../widgets/auth/auth_header.dart';
import '../widgets/auth/custom_button.dart';
import '../widgets/auth/custom_text_field.dart';
import '../widgets/auth/google_sign_in_button.dart';
// import '../home/home_page.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();
  
  LoginScreen({super.key});

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
                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'Your Email Or Number Phone',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: controller.passwordController,
                  hintText: 'Your Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                Obx(() => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                      text: 'Sign In',
                      onPressed: controller.login,
                    ),
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
                      onTap: () => Get.toNamed(AppPages.REGISTER),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
