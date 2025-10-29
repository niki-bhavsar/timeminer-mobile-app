import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Time Miner'**
  String get app_name;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Time Miner'**
  String get welcome;

  /// No description provided for @login_description.
  ///
  /// In en, this message translates to:
  /// **'The first-ever automatic, retroactive time capture tool created by attorneys.'**
  String get login_description;

  /// No description provided for @loginScreen_emailInput_emptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get loginScreen_emailInput_emptyError;

  /// No description provided for @loginScreen_emailInput_invalidError.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid email'**
  String get loginScreen_emailInput_invalidError;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signUpText.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get signUpText;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @forgot_password_screen_title.
  ///
  /// In en, this message translates to:
  /// **'You forgot your password?'**
  String get forgot_password_screen_title;

  /// No description provided for @forgot_password_screen_description.
  ///
  /// In en, this message translates to:
  /// **'Here you can easily retrieve a new password.'**
  String get forgot_password_screen_description;

  /// No description provided for @forgot_password_screen_forgot_button_title.
  ///
  /// In en, this message translates to:
  /// **'Send Password Reset Link'**
  String get forgot_password_screen_forgot_button_title;

  /// No description provided for @back_button_title.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get back_button_title;

  /// No description provided for @set_password_passwordInput_emptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get set_password_passwordInput_emptyError;

  /// No description provided for @set_password_screen_passwordInput_hint.
  ///
  /// In en, this message translates to:
  /// **'Password*'**
  String get set_password_screen_passwordInput_hint;

  /// No description provided for @contact_sync.
  ///
  /// In en, this message translates to:
  /// **'Sync Contacts'**
  String get contact_sync;

  /// No description provided for @sync_now.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get sync_now;

  /// No description provided for @last_sync.
  ///
  /// In en, this message translates to:
  /// **'Last sync: '**
  String get last_sync;

  /// No description provided for @settingsScreen_general_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsScreen_general_logout;

  /// No description provided for @settingsScreen_logoutDialog_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get settingsScreen_logoutDialog_message;

  /// No description provided for @action_ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get action_ok;

  /// No description provided for @action_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get action_cancel;

  /// No description provided for @action_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get action_yes;

  /// A message with a distributor name
  ///
  /// In en, this message translates to:
  /// **'You’re logged in as a {distributor} representative. Click Delete to remove the distributor.'**
  String myPreferenceScreen_distributor_info(String distributor);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
