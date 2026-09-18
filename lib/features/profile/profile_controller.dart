import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/data_source/local_data/prefrence_manager.dart';
import 'package:news_app/core/mixin/safe_notifier_mixin.dart';

class ProfileController extends ChangeNotifier with SafeNotify {
  XFile? selectedImage;

  String? userName;
  String? countryCode;
  String? countryName;

  ProfileController() {
    getUserData();
  }

  void pickImage(ImageSource source) async {
    selectedImage = await ImagePicker().pickImage(source: source);

    safeNotify();
  }

  getUserData() {
    userName = PrefrenceManager().getString('username') ?? "";

    countryName = PrefrenceManager().getString("country_name");
    countryCode = PrefrenceManager().getString("country_code");
    safeNotify();
  }

  void saveCountry(Country selectedCountry) async {
    await PrefrenceManager().setString("country_name", selectedCountry.name);
    await PrefrenceManager().setString("country_code", selectedCountry.countryCode);
    countryName = selectedCountry.name;
    countryCode = selectedCountry.countryCode;

    safeNotify();
  }
}
