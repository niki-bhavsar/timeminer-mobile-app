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

  /// No description provided for @signup_description.
  ///
  /// In en, this message translates to:
  /// **'The first-ever automatic, retroactive time capture tool created by attorneys.Time Miner seamlessly captures more of your billable time without changing the way you work.'**
  String get signup_description;

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

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @complete_your_account.
  ///
  /// In en, this message translates to:
  /// **'Complete your account setup'**
  String get complete_your_account;

  /// No description provided for @step_1.
  ///
  /// In en, this message translates to:
  /// **'STEP 1 OF 4'**
  String get step_1;

  /// No description provided for @send_mail_description.
  ///
  /// In en, this message translates to:
  /// **'A sign-up link will be sent to {email} Use it to log in to Time Miner instantly, from any device, without a password.'**
  String send_mail_description(Object email);

  /// No description provided for @send_link.
  ///
  /// In en, this message translates to:
  /// **'Send Link'**
  String get send_link;

  /// No description provided for @step_2.
  ///
  /// In en, this message translates to:
  /// **'STEP 2 OF 4'**
  String get step_2;

  /// No description provided for @look_inbox.
  ///
  /// In en, this message translates to:
  /// **'Look in your inbox'**
  String get look_inbox;

  /// No description provided for @look_inbox_description.
  ///
  /// In en, this message translates to:
  /// **'We sent a link to {email} open your email and finish your setup in seconds.'**
  String look_inbox_description(Object email);

  /// No description provided for @resend_link.
  ///
  /// In en, this message translates to:
  /// **'Resend Link'**
  String get resend_link;

  /// No description provided for @create_password.
  ///
  /// In en, this message translates to:
  /// **'Create Password Instead'**
  String get create_password;

  /// No description provided for @set_password_title.
  ///
  /// In en, this message translates to:
  /// **'Create your password to begin.'**
  String get set_password_title;

  /// No description provided for @set_password_description.
  ///
  /// In en, this message translates to:
  /// **'You’re almost done! Just a few quick steps—no endless paperwork required.'**
  String get set_password_description;

  /// No description provided for @set_password_passwordInput_emptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get set_password_passwordInput_emptyError;

  /// No description provided for @set_password_confirm_passwordInput_emptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter confirm password'**
  String get set_password_confirm_passwordInput_emptyError;

  /// No description provided for @set_password_passwordandconfirm_password_missmatch.
  ///
  /// In en, this message translates to:
  /// **'Password and confirm password not match'**
  String get set_password_passwordandconfirm_password_missmatch;

  /// No description provided for @set_password_screen_passwordInput_hint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get set_password_screen_passwordInput_hint;

  /// No description provided for @set_password_screen_confirm_passwordInput_hint.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get set_password_screen_confirm_passwordInput_hint;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @set_password_skip_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Great! Let’s verify your email to continue.'**
  String get set_password_skip_screen_title;

  /// No description provided for @set_password_skip_screen_description.
  ///
  /// In en, this message translates to:
  /// **'We’ve sent a link to {email} \n\n tap it to verify your email. This keeps your account secure and makes sure you don’t miss important updates from Time Miner'**
  String set_password_skip_screen_description(Object email);

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

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
