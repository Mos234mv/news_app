import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/data_source/local_data/user_repository.dart';
import 'package:news_app/core/mixin/safe_notifier_mixin.dart';
import 'package:news_app/core/models/user_model.dart';

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
    final UserModel? user = UserRepository().getUser();
    userName = user?.name ?? "";
    countryName = user?.countryName;
    countryCode = user?.countryCode;
    safeNotify();
  }

  void saveCountry(Country selectedCountry) async {
    await UserRepository().updateUser(
      countryName: selectedCountry.name,
      countryCode: selectedCountry.countryCode,
    );
    countryName = selectedCountry.name;
    countryCode = selectedCountry.countryCode;

    safeNotify();
  }
}
