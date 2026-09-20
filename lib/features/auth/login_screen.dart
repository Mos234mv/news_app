import 'package:flutter/material.dart';

import 'package:news_app/core/data_source/local_data/user_repository.dart';
import 'package:news_app/features/Navigation/main_screen.dart';
import 'package:news_app/features/auth/customtextformfilled.dart';
import 'package:news_app/features/auth/register_screen.dart';

import '../../core/constant/app_sizes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  String? errorMessage;
  bool isLoading = false;

  void logIn() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3));
    final String? error = await UserRepository().login(
      emailController.text,
      passwordController.text,
    );

    if (error != null) {
      setState(() {
        errorMessage = error;
        isLoading = false;
      });
      return;
    }

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return MainScreen();
        },
      ),
    );
    setState(() {
      errorMessage = null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bkg_image.png')),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.all(AppSizes.pw16),
                      child: Form(
                        key: form,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Image.asset('assets/images/logo_news.png')),

                            SizedBox(height: AppSizes.ph24),
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
                            if (errorMessage != null)
                              Text(errorMessage!, style: TextStyle(color: Colors.red)),
                            SizedBox(height: AppSizes.ph20),
                            SizedBox(
                              height: AppSizes.h48,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (form.currentState?.validate() ?? false) {
                                    logIn();
                                  }
                                },
                                child: isLoading
                                    ? CircularProgressIndicator()
                                    : Text('Sign In'),
                              ),
                            ),
                            SizedBox(height: AppSizes.ph24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don’t have an account ?',
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
                                          return RegisterScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text("Sign Up"),
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
            },
          ),
        ),
      ),
    );
  }
}
