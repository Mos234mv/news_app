import 'package:flutter/material.dart';
import 'package:news_app/features/auth/customtextformfilled.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
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
                obscureText: false,
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
                obscureText: true,
              ),
              CustomTextFormFilled(
                controller: confirmPasswordController,
                hintText: "***********",
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter Your Password";
                  }
                  return null;
                },
                title: 'Confirm Passward',
                obscureText: true,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(onPressed: () {}, child: Text('Sign Up')),
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
                      Navigator.pop(context);
                    },
                    child: Text("Sign In"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
