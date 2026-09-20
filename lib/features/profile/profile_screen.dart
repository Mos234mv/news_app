import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/Theme/light_color.dart';
import 'package:news_app/core/constant/app_sizes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/data_source/local_data/user_repository.dart';
import 'package:news_app/core/widgets/custom_svg.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/profile/bottom%20sheet/profile_info_bottomsheet.dart';
import 'package:news_app/features/profile/profile_controller.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileController>(
      create: (context) => ProfileController(),
      child: Scaffold(
        appBar: AppBar(title: Text('Profile'), centerTitle: true),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.ph24,
            horizontal: AppSizes.ph16,
          ),
          child: Consumer<ProfileController>(
            builder: (BuildContext context, controller, Widget? child) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundImage: controller.selectedImage == null
                                ? AssetImage('assets/images/profileImage.png')
                                : FileImage(File(controller.selectedImage!.path)),
                            radius: AppSizes.r60,
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () {
                              showImageSourceDialog(context);
                            },
                            child: Container(
                              height: AppSizes.h34,
                              width: AppSizes.w34,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xFFFFFFFF),
                              ),
                              child: Icon(Icons.camera_alt_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSizes.ph8),
                    Center(
                      child: Text(
                        controller.userName ?? "",
                        style: TextStyle(color: Colors.black, fontSize: AppSizes.sp16),
                      ),
                    ),
                    _buildProfileItem(
                      "Personal Info",
                      "assets/images/profileicon.svg",
                      () async {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            return ProfileInfoBottomsheet();
                          },
                        ).then((value) {
                          controller.getUserData();
                        });
                      },
                    ),
                    _buildProfileItem(
                      "Language",
                      "assets/images/languageicon.svg",
                      () {},
                    ),
                    _buildProfileItem(
                      controller.countryName ?? "Country",
                      "assets/images/countryicon.svg",
                      () {
                        showCountryPicker(
                          countryListTheme: CountryListThemeData(
                            flagSize: 20,
                            backgroundColor: Color(0xFFF5F5F5),
                            textStyle: Theme.of(context).textTheme.titleLarge,
                            bottomSheetHeight: 500, // Optional. Country list modal height
                            //Optional. Sets the border radius for the bottomsheet.
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            //Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          context: context,
                          onSelect: (Country country) {
                            controller.saveCountry(country);
                          },
                        );
                      },
                    ),
                    _buildProfileItem(
                      "Terms & Conditions",
                      "assets/images/condationicon.svg",
                      () {},
                    ),
                    _buildProfileItem(
                      "Logout",
                      "assets/images/logout.svg",
                      () async {
                        await UserRepository().logout();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                      color: LightColor.primaryColor,
                      isDivider: false,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void showImageSourceDialog(BuildContext context) {
  final controller = context.read<ProfileController>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text("Select Image Source", style: TextStyle(fontSize: AppSizes.sp16)),
        backgroundColor: Colors.white,
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              controller.pickImage(ImageSource.camera);
            },
            padding: EdgeInsets.all(AppSizes.pw16),
            child: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: AppSizes.pw8),
                Text(
                  "Camera",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              controller.pickImage(ImageSource.gallery);
            },
            padding: EdgeInsets.all(AppSizes.pw16),
            child: Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: AppSizes.pw8),
                Text(
                  "Galley",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildProfileItem(
  String title,
  String path,
  Function ontap, {
  Color color = const Color(0xFF161F1B),
  bool isDivider = true,
}) {
  return Column(
    children: [
      ListTile(
        onTap: () => ontap(),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: AppSizes.sp16,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: CustomSvgPicture(
          path: path,
          height: AppSizes.w20,
          width: AppSizes.w20,
          withColor: false,
        ),
        trailing: CustomSvgPicture(
          path: 'assets/images/arrow__.svg',
          height: AppSizes.w16,
          width: AppSizes.w16,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.pw8),
      ),
      if (isDivider) Divider(color: Color(0x1ffD1DAD6), thickness: 2),
    ],
  );
}
