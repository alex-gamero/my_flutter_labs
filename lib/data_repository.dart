// A simple repository using EncryptedSharedPreferences
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository {
  DataRepository._internal();
  static final DataRepository instance = DataRepository._internal();

  late EncryptedSharedPreferences _prefs;

  String firstName = '';
  String lastName = '';
  String phone = '';
  String email = '';

  // initialize prefs & load stored values
  Future<void> init() async {
    _prefs = EncryptedSharedPreferences();
    await loadData();
  }

  Future<void> loadData() async {
    try {
      firstName = await _prefs.getString('firstName');
    } catch (_) {
      firstName = '';
    }

    try {
      lastName = await _prefs.getString('lastName');
    } catch (_) {
      lastName = '';
    }

    try {
      phone = await _prefs.getString('phone');
    } catch (_) {
      phone = '';
    }

    try {
      email = await _prefs.getString('email');
    } catch (_) {
      email = '';
    }
  }

  Future<void> saveData() async {
    await _prefs.setString('firstName', firstName);
    await _prefs.setString('lastName', lastName);
    await _prefs.setString('phone', phone);
    await _prefs.setString('email', email);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
    firstName = '';
    lastName = '';
    phone = '';
    email = '';
  }
}