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
  String get signup_description => 'The first-ever automatic, retroactive time capture tool created by attorneys.Time Miner seamlessly captures more of your billable time without changing the way you work.';

  @override
  String get loginScreen_emailInput_emptyError => 'Please enter email';

  @override
  String get loginScreen_emailInput_invalidError => 'Please enter valid email';

  @override
  String get login => 'Login';

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
  String get get_started => 'Get Started';

  @override
  String get complete_your_account => 'Complete your account setup';

  @override
  String send_mail_description(Object email) {
    return 'A sign-up link will be sent to $email Use it to log in to Time Miner instantly, from any device, without a password.';
  }

  @override
  String get send_link => 'Send Link';

  @override
  String get step_1 => 'STEP 1 OF 4';

  @override
  String get step_2 => 'STEP 2 OF 4';

  @override
  String get step_3 => 'STEP 3 OF 4';

  @override
  String get look_inbox => 'Look in your inbox';

  @override
  String look_inbox_description(Object email) {
    return 'We sent a link to $email open your email and finish your setup in seconds.';
  }

  @override
  String get resend_link => 'Resend Link';

  @override
  String get create_password => 'Create Password Instead';

  @override
  String get set_password_title => 'Create your password to begin.';

  @override
  String get set_password_description => 'You’re almost done! Just a few quick steps—no endless paperwork required.';

  @override
  String get set_password_passwordInput_emptyError => 'Please enter password';

  @override
  String get set_password_confirm_passwordInput_emptyError => 'Please enter confirm password';

  @override
  String get set_password_passwordandconfirm_password_missmatch => 'Password and confirm password not match';

  @override
  String get set_password_screen_passwordInput_hint => 'Password*';

  @override
  String get set_password_screen_confirm_passwordInput_hint => 'Confirm Password';

  @override
  String get next => 'Next';

  @override
  String get set_password_skip_screen_title => 'Great! Let’s verify your email to continue.';

  @override
  String set_password_skip_screen_description(Object email) {
    return 'We’ve sent a link to $email \n\n tap it to verify your email. This keeps your account secure and makes sure you don’t miss important updates from Time Miner';
  }

  @override
  String get skip => 'Skip';

  @override
  String get plan_selection_screen_title => 'Pick the plan that works best for you.';

  @override
  String get contact_sync => 'Sync Contacts';

  @override
  String myPreferenceScreen_distributor_info(String distributor) {
    return 'You’re logged in as a $distributor representative. Click Delete to remove the distributor.';
  }
}
