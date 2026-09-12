import 'package:flutter/material.dart';
import 'package:news_app/core/data_source/local_data/prefrence_manager.dart';

import 'package:news_app/features/Navigation/main_screen.dart';
import 'package:news_app/features/auth/customtextformfilled.dart';
import 'package:news_app/features/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool isLoading = false;

  void register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3));
    final savedEmail = PrefrenceManager().getString('user_email');
    if (savedEmail != null && savedEmail == emailController.text.trim()) {
      setState(() {
        errorMessage = 'User Already Register';
        isLoading = false;
      });
    } else {
      await PrefrenceManager().setString('user_email', emailController.text);
      await PrefrenceManager().setString(
        'user_password',
        passwordController.text,
      );
      await PrefrenceManager().setBool("is_loged_in", true);
      setState(() {
        isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
      );
    }
  }

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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/images/logo_news.png')),

                SizedBox(height: 24),
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

                    // Defines the regex for:
                    // 1 Uppercase, 1 Lowercase, 1 Number, 1 Special Character, Minimum 8 Characters
                    // final passwordRegEx = RegExp(
                    //   r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                    // );

                    // // ADDED '!': If the value DOES NOT match the regex, return the error.
                    // if (!passwordRegEx.hasMatch(value)) {
                    //   return "Please Enter Valid Password";
                    // }

                    // Return null if all checks pass (meaning the password is valid)
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

                    // Defines the regex for:
                    // 1 Uppercase, 1 Lowercase, 1 Number, 1 Special Character, Minimum 8 Characters
                    // final passwordRegEx = RegExp(
                    //   r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                    // );

                    // // ADDED '!': If the value DOES NOT match the regex, return the error.
                    // if (!passwordRegEx.hasMatch(value)) {
                    //   return "Please Enter Valid Password";
                    // }

                    // Return null if all checks pass (meaning the password is valid)
                    return null;
                  },
                  title: 'Confirm Passward',
                  obscureText: true,
                ),
                if (errorMessage != null)
                  Text(errorMessage!, style: TextStyle(color: Colors.red)),
                SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        register();
                        Navigator.pop(context);
                      }
                    },
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text('Sign Up'),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account ?',
                      style: Theme.of(context).textTheme.titleLarge!
                          .copyWith(fontSize: 14),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
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
    );
  }
}
