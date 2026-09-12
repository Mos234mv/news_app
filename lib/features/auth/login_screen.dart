import 'package:flutter/material.dart';
import 'package:news_app/core/data_source/local_data/prefrence_manager.dart';
import 'package:news_app/features/Navigation/main_screen.dart';
import 'package:news_app/features/auth/customtextformfilled.dart';
import 'package:news_app/features/auth/register_screen.dart';

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
    final savedEmail = PrefrenceManager().getString('user_email');
    final savedPassword = PrefrenceManager().getString('user_password');

    if (savedEmail == null || savedPassword == null) {
      setState(() {
        errorMessage = 'No Account Found Please Register First';
        isLoading = false;
      });
      return;
    }

    if (savedEmail != emailController.text ||
        savedPassword != passwordController.text) {
      setState(() {
        errorMessage = 'Incorrect Email or Password';
        isLoading = false;
      });
      return;
    }

    await PrefrenceManager().setBool("is_loged_in", true);

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

                    return null;
                  },
                  title: "Password",
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
                      if (form.currentState?.validate() ?? false) {
                        logIn();
                      }
                    },
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text('Sign In'),
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
