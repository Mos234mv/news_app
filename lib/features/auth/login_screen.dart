import 'package:flutter/material.dart';
import 'package:news_app/features/auth/customtextformfilled.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bkg_image.png'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset('assets/images/logo_news.png')),

              SizedBox(height: 24),
              CustomTextFormFilled(
                controller: emailController,
                hintText: 'mostafaamed.net@gmail.com',
                title: 'Email',
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter Your Email";
                  }
                  return null;
                },
              ),
              CustomTextFormFilled(
                controller: passwordController,
                hintText: "***********",
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter Your Password";
                  }
                  return null;
                },
                title: "Password",
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  icon: isPassword
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
