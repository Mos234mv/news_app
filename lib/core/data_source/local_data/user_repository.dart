// ignore_for_file: unused_field, unnecessary_import

import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/core/data_source/local_data/prefrence_manager.dart';
import 'package:news_app/core/models/user_model.dart';

class UserRepository {
  UserRepository._internal();
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;
  Box<UserModel>? _userBox;
  Box<UserModel> get userBox {
    if (_userBox == null) {
      throw Exception("UserRepository not initialized");
    }
    return _userBox!;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }

    _userBox = await Hive.openBox(Constants.userBox);
  }

  Future<void> saveUser(UserModel user) async {
    await userBox.put(Constants.currentUser, user);
  }

  UserModel? getUser() => userBox.get(Constants.currentUser);

  bool isLoggedIn() {
    return PrefrenceManager().getBool("is_loged_in") ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    await PrefrenceManager().setBool("is_loged_in", value);
  }

  Future<void> logout() async {
    await setLoggedIn(false);
  }

  Future<void> updateUser({
    String? name,
    String? email,
    String? password,
    String? countryCode,
    String? countryName,
  }) async {
    final UserModel? user = getUser();

    if (user != null) {
      final updatedUser = user.copyWith(
        name: name,
        email: email,
        password: password,
        countryCode: countryCode,
        countryName: countryName,
      );

      await saveUser(updatedUser);
    }
  }

  Future<void> delete() async {
    await userBox.delete(Constants.currentUser);
    await logout();
  }

  Future<void> clearAll() async {
    await userBox.clear();
    await logout();
  }

  Future<String?> login(String email, String password) async {
    final user = getUser();

    if (user == null) {
      return "No Account Found Please Register First";
    }

    if (user.email != email || user.password != password) {
      return "Incorrect Email or Password";
    }

    await setLoggedIn(true);
    return null;
  }

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = getUser();

    if (user != null) {
      return "User Already Exists Please Login";
    }

    final newUser = UserModel(name: name, email: email, password: password);

    await saveUser(newUser);
    return null;
  }
}
