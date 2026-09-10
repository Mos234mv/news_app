import 'package:flutter/material.dart';
import 'package:news_app/features/auth/customtextformfilled.dart';
import 'package:news_app/features/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

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
            key: form,
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
                SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (form.currentState?.validate() ?? false) {}
                    },
                    child: Text('Sign In'),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account ?',
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
    );
  }
}
