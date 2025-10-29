// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Time Miner';

  @override
  String get welcome => 'Welcome to Time Miner';

  @override
  String get login_description => 'The first-ever automatic, retroactive time capture tool created by attorneys.';

  @override
  String get loginScreen_emailInput_emptyError => 'Please enter email';

  @override
  String get loginScreen_emailInput_invalidError => 'Please enter valid email';

  @override
  String get login => 'Login';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signUpText => 'Don\'t have an account?';

  @override
  String get rememberMe => 'Remember Me';

  @override
  String get forgot_password => 'Forgot Password?';

  @override
  String get forgot_password_screen_title => 'You forgot your password?';

  @override
  String get forgot_password_screen_description => 'Here you can easily retrieve a new password.';

  @override
  String get forgot_password_screen_forgot_button_title => 'Send Password Reset Link';

  @override
  String get back_button_title => 'Back to login';

  @override
  String get set_password_passwordInput_emptyError => 'Please enter password';

  @override
  String get set_password_screen_passwordInput_hint => 'Password*';

  @override
  String get contact_sync => 'Sync Contacts';

  @override
  String get sync_now => 'Sync Now';

  @override
  String get last_sync => 'Last sync: ';

  @override
  String get settingsScreen_general_logout => 'Logout';

  @override
  String get settingsScreen_logoutDialog_message => 'Are you sure you want to logout?';

  @override
  String get action_ok => 'Ok';

  @override
  String get action_cancel => 'Cancel';

  @override
  String get action_yes => 'Yes';

  @override
  String myPreferenceScreen_distributor_info(String distributor) {
    return 'You’re logged in as a $distributor representative. Click Delete to remove the distributor.';
  }
}
