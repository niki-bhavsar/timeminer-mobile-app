import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../entity/contacts_entity.dart';
import 'session_pref.dart';

class SessionPrefImpl implements SessionPref {
  static const String _isLoggedIn = 'profile.is_logged_in';
  static const String _userProfilePath = 'session.user_profile_path';
  static const String _authToken = 'session.auth_token';
  static const String _firmCode = 'session.firm_code';
  static const String _signUpEmail = 'session.sign_up_email';
  static const String _userName = 'session.user_name';
  static const String _contacts = 'session.contacts';

  final SharedPreferences prefs;

  SessionPrefImpl(this.prefs);

  @override
  setLoggedIn(bool loggedIn) {
    prefs.setBool(_isLoggedIn, loggedIn);
  }

  @override
  bool isLoggedIn() => prefs.getBool(_isLoggedIn) ?? false;

  @override
  String getAuthToken() {
    return prefs.getString(_authToken) ?? "";
  }

  @override
  setAuthToken(String authToken) {
    prefs.setString(_authToken, authToken);
  }

  @override
  String getFirmCode() {
    return prefs.getString(_firmCode) ?? "";
  }

  @override
  setFirmCode(String firmCode) {
    prefs.setString(_firmCode, firmCode);
  }

  @override
  String getSignUpEmail() {
    return prefs.getString(_signUpEmail) ?? "";
  }

  @override
  setSignUpEmail(String email) {
    prefs.setString(_signUpEmail, email);
  }
  @override
  String getSignUpUserName() {
    return prefs.getString(_userName) ?? "";
  }

  @override
  setSignUpUserName(String userName) {
    prefs.setString(_userName, userName);
  }
  
  @override String? getUserProfile() {
    return prefs.getString(_userProfilePath);
  }
  @override
  setUserProfile(String? profileUrl) {
    if (profileUrl != null) {
      prefs.setString(_userProfilePath, profileUrl);
    } else {
      prefs.remove(_userProfilePath);
    }
  }
  
  @override
  Future clear() async {
    await prefs.remove(_isLoggedIn);
    await prefs.remove(_userProfilePath);
    await prefs.remove(_authToken);
    await prefs.remove(_firmCode);
    await prefs.remove(_signUpEmail);
    await prefs.remove(_contacts);
    await prefs.reload();
  }

  @override
  Future<void> setContacts(ContactsEntity contacts) async {
    final jsonString = jsonEncode({
      'message': contacts.message,
      'success': contacts.success,
      'contactItems': contacts.contactItems.map((item) => {
        'id': item.id,
        'name': item.name,
        'email': item.email,
        'mine_status': item.mineStatus ? 1 : 0,
        'created_at': item.createdAt,
        'updated_at': item.updatedAt,
        'phone_numbers': item.phoneNumbers?.map((phone) => {
          'id': phone.id,
          'phone_number': phone.phoneNumber,
        }).toList(),
      }).toList(),
    });
    await prefs.setString(_contacts, jsonString);
  }

  @override
  ContactsEntity? getContacts() {
    final jsonString = prefs.getString(_contacts);
    if (jsonString == null) return null;
    
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final contactItems = (json['contactItems'] as List?)
          ?.map((item) {
            final phoneNumbers = (item['phone_numbers'] as List?)
                ?.map((phone) => ContactPhoneNumber(
                      id: phone['id'],
                      phoneNumber: phone['phone_number'] ?? '',
                    ))
                .toList();
            
            return ContactItem(
              id: item['id'],
              name: item['name'],
              email: item['email'],
              mineStatus: (item['mine_status'] == 1),
              createdAt: item['created_at'],
              updatedAt: item['updated_at'],
              phoneNumbers: phoneNumbers,
            );
          })
          .toList() ?? [];
      
      return ContactsEntity(
        message: json['message'] ?? '',
        success: json['success'] ?? false,
        contactItems: contactItems,
      );
    } catch (e) {
      print('Error parsing stored contacts: $e');
      return null;
    }
  }

  @override
  Future<void> clearContacts() async {
    await prefs.remove(_contacts);
  }
}
