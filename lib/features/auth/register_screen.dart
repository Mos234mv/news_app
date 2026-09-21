import 'package:flutter/material.dart';

import 'package:news_app/core/data_source/local_data/user_repository.dart';

import 'package:news_app/features/auth/customtextformfilled.dart';
import 'package:news_app/features/auth/login_screen.dart';

import '../../core/constant/app_sizes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool isLoading = false;

  void register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3));
    if (!mounted) return;
    final String? error = await UserRepository().signUp(
      email: emailController.text,
      password: passwordController.text,
      name: usernameController.text,
    );
    if (error != null) {
      setState(() {
        errorMessage = error;
        isLoading = false;
      });
      return;
    }
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bkg_image.png')),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.pw16),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset('assets/images/logo_news.png')),

                  Text(
                    'Welcome to Newts',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  SizedBox(height: AppSizes.ph16),
                  CustomTextFormFilled(
                    controller: usernameController,
                    hintText: 'Mostafa Ahmed',
                    title: 'Username',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Username";
                      }
                      return null;
                    },
                    obscureText: false,
                  ),

                  CustomTextFormFilled(
                    controller: emailController,
                    hintText: 'mostafaamed.net@gmail.com',
                    title: 'Email',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Email";
                      }

                      RegExp emailRegExp = RegExp(
                        r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );

                      if (!emailRegExp.hasMatch(value)) {
                        return 'Please Enter Valid Email';
                      } else {
                        return null;
                      }
                    },
                    obscureText: false,
                  ),

                  CustomTextFormFilled(
                    controller: passwordController,
                    hintText: "***********",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Password";
                      }
                      return null;
                    },
                    title: "Password",
                    obscureText: true,
                  ),
                  CustomTextFormFilled(
                    controller: confirmPasswordController,
                    hintText: "***********",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Password";
                      }
                      return null;
                    },
                    title: 'Confirm Passward',
                    obscureText: true,
                  ),
                  if (errorMessage != null)
                    Text(errorMessage!, style: TextStyle(color: Colors.red)),
                  SizedBox(height: AppSizes.ph20),
                  SizedBox(
                    height: AppSizes.h48,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          register();
                        }
                      },
                      child: isLoading ? CircularProgressIndicator() : Text('Sign Up'),
                    ),
                  ),
                  SizedBox(height: AppSizes.ph24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account ?',
                        style: Theme.of(context).textTheme.titleLarge!
                            .copyWith(fontSize: AppSizes.sp14),
                      ),
                      SizedBox(width: AppSizes.pw8),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return LoginScreen();
                              },
                            ),
                          );
                        },
                        child: Text("Sign In"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
