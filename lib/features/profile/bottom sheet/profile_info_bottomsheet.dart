import 'package:flutter/material.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:news_app/core/data_source/local_data/user_repository.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/features/auth/customtextformfilled.dart';

class ProfileInfoBottomsheet extends StatefulWidget {
  const ProfileInfoBottomsheet({super.key});

  @override
  State<ProfileInfoBottomsheet> createState() => _ProfileInfoBottomsheetState();
}

class _ProfileInfoBottomsheetState extends State<ProfileInfoBottomsheet> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final UserModel? user = UserRepository().getUser();
    emailController.text = user?.email ?? "";
    usernameController.text = user?.name ?? "";
  }

  void _saveData() async {
    if (formKey.currentState?.validate() ?? false) {
      UserRepository().updateUser(
        email: emailController.text,
        name: usernameController.text,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.r16),
          topRight: Radius.circular(AppSizes.r16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.pw16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: AppSizes.h6,
                    width: AppSizes.w40,
                    decoration: BoxDecoration(
                      color: Color(0xFF363636),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.h16),
                Text('Profile Info', style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: AppSizes.h16),
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
                SizedBox(height: AppSizes.ph40),
                SizedBox(
                  height: AppSizes.h48,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _saveData();
                    },

                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
