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
  /// **'Compass Software'**
  String get app_name;

  /// No description provided for @action_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get action_next;

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

  /// No description provided for @action_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get action_no;

  /// No description provided for @action_update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get action_update;

  /// No description provided for @action_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get action_edit;

  /// No description provided for @action_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get action_delete;

  /// No description provided for @action_try_again.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get action_try_again;

  /// No description provided for @stateView_message.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get stateView_message;

  /// No description provided for @no_data_message.
  ///
  /// In en, this message translates to:
  /// **'No data Found'**
  String get no_data_message;

  /// No description provided for @back_button_title.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back_button_title;

  /// No description provided for @distributorCodeScreen_codeInput_title.
  ///
  /// In en, this message translates to:
  /// **'Enter the Distributor Code'**
  String get distributorCodeScreen_codeInput_title;

  /// No description provided for @distributorCodeScreen_codeInput_hint.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get distributorCodeScreen_codeInput_hint;

  /// No description provided for @distributorCodeScreen_codeInput_emptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter code'**
  String get distributorCodeScreen_codeInput_emptyError;

  /// No description provided for @distributorCodeScreen_invalidCode_message.
  ///
  /// In en, this message translates to:
  /// **'The code you entered is invalid.'**
  String get distributorCodeScreen_invalidCode_message;

  /// No description provided for @loginScreen_title.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginScreen_title;

  /// No description provided for @loginScreen_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please login to your Account'**
  String get loginScreen_subtitle;

  /// No description provided for @loginScreen_login_action.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginScreen_login_action;

  /// No description provided for @loginScreen_emailInput_hint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginScreen_emailInput_hint;

  /// No description provided for @loginScreen_passwordInput_hint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginScreen_passwordInput_hint;

  /// No description provided for @loginScreen_emailInput_emptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get loginScreen_emailInput_emptyError;

  /// No description provided for @loginScreen_passwordInput_emptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get loginScreen_passwordInput_emptyError;

  /// No description provided for @loginScreen_invalidCredential_message.
  ///
  /// In en, this message translates to:
  /// **'The email or password you entered is incorrect.'**
  String get loginScreen_invalidCredential_message;

  /// No description provided for @bottomMenuScreen_tabSchedule_title.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get bottomMenuScreen_tabSchedule_title;

  /// No description provided for @bottomMenuScreen_tabProfiles_title.
  ///
  /// In en, this message translates to:
  /// **'Profiles'**
  String get bottomMenuScreen_tabProfiles_title;

  /// No description provided for @bottomMenuScreen_tabSales_title.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get bottomMenuScreen_tabSales_title;

  /// No description provided for @bottomMenuScreen_tabSettings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get bottomMenuScreen_tabSettings_title;

  /// No description provided for @tryAgain_button_title.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain_button_title;

  /// No description provided for @announcementScreen_title.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get announcementScreen_title;

  /// No description provided for @announcementScreen_noData_message.
  ///
  /// In en, this message translates to:
  /// **'No Announcements Found'**
  String get announcementScreen_noData_message;

  /// No description provided for @announcementScreen_detail_title.
  ///
  /// In en, this message translates to:
  /// **'Announcement Details'**
  String get announcementScreen_detail_title;

  /// No description provided for @techniqueLibraryScreen_title.
  ///
  /// In en, this message translates to:
  /// **'Technique Library'**
  String get techniqueLibraryScreen_title;

  /// No description provided for @techniqueLibraryScreen_noData_message.
  ///
  /// In en, this message translates to:
  /// **'No Technique Library Found'**
  String get techniqueLibraryScreen_noData_message;

  /// No description provided for @techniqueLibraryScreen_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get techniqueLibraryScreen_search_hint;

  /// No description provided for @techniqueLibraryScreen_anatomy_title.
  ///
  /// In en, this message translates to:
  /// **'Anatomy'**
  String get techniqueLibraryScreen_anatomy_title;

  /// No description provided for @techniqueLibraryScreen_system_title.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get techniqueLibraryScreen_system_title;

  /// No description provided for @techniqueLibraryDetailScreen_failed_document_message.
  ///
  /// In en, this message translates to:
  /// **'Failed to load the document. Please try again later'**
  String get techniqueLibraryDetailScreen_failed_document_message;

  /// No description provided for @techniqueLibraryDetailScreen_failed_alert_title.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get techniqueLibraryDetailScreen_failed_alert_title;

  /// No description provided for @templateListScreen_title.
  ///
  /// In en, this message translates to:
  /// **'Templates List'**
  String get templateListScreen_title;

  /// No description provided for @createNewTemplate_title.
  ///
  /// In en, this message translates to:
  /// **'Add Template'**
  String get createNewTemplate_title;

  /// No description provided for @editTemplate_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Template'**
  String get editTemplate_title;

  /// No description provided for @createEditTemplate_nameInput_hint.
  ///
  /// In en, this message translates to:
  /// **'Template Name'**
  String get createEditTemplate_nameInput_hint;

  /// No description provided for @createEditTemplate_nameInput_emptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter template name'**
  String get createEditTemplate_nameInput_emptyError;

  /// No description provided for @createEditTemplate_Implants_segment_title.
  ///
  /// In en, this message translates to:
  /// **'Implants'**
  String get createEditTemplate_Implants_segment_title;

  /// No description provided for @createEditTemplate_Instruments_segment_title.
  ///
  /// In en, this message translates to:
  /// **'Instruments'**
  String get createEditTemplate_Instruments_segment_title;

  /// No description provided for @createEditTemplate_empty_implant_instruments_title.
  ///
  /// In en, this message translates to:
  /// **'Unknown Manufacturer'**
  String get createEditTemplate_empty_implant_instruments_title;

  /// No description provided for @createEditTemplate_empty_implant_instruments_no_data.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get createEditTemplate_empty_implant_instruments_no_data;

  /// No description provided for @createEditTemplate_implant_noData_message.
  ///
  /// In en, this message translates to:
  /// **'No Data  Found'**
  String get createEditTemplate_implant_noData_message;

  /// No description provided for @template_filter_categories_title.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get template_filter_categories_title;

  /// No description provided for @template_kit_detail_title.
  ///
  /// In en, this message translates to:
  /// **'Kit Details'**
  String get template_kit_detail_title;

  /// No description provided for @template_kit_Unknown_Value.
  ///
  /// In en, this message translates to:
  /// **'Unknown Value'**
  String get template_kit_Unknown_Value;

  /// No description provided for @template_category_dropdown_title.
  ///
  /// In en, this message translates to:
  /// **'Choose an Item'**
  String get template_category_dropdown_title;

  /// No description provided for @template_category_dropdown_Selected_title.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get template_category_dropdown_Selected_title;

  /// No description provided for @template_category_dropdown_All_title.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get template_category_dropdown_All_title;

  /// No description provided for @companydirectoryscreen_title.
  ///
  /// In en, this message translates to:
  /// **'Company Directory'**
  String get companydirectoryscreen_title;

  /// No description provided for @companydirectoryScreen_noData_message.
  ///
  /// In en, this message translates to:
  /// **'No Company Directory Found'**
  String get companydirectoryScreen_noData_message;

  /// No description provided for @companydirectory_role_title.
  ///
  /// In en, this message translates to:
  /// **'Role : '**
  String get companydirectory_role_title;

  /// No description provided for @companydirectory_region_title.
  ///
  /// In en, this message translates to:
  /// **'Region : '**
  String get companydirectory_region_title;

  /// No description provided for @companydirectory_office_title.
  ///
  /// In en, this message translates to:
  /// **'Office : '**
  String get companydirectory_office_title;

  /// No description provided for @companydirectory_phone_title.
  ///
  /// In en, this message translates to:
  /// **'Phone : '**
  String get companydirectory_phone_title;

  /// No description provided for @companydirectory_groupname_title.
  ///
  /// In en, this message translates to:
  /// **'Group : '**
  String get companydirectory_groupname_title;

  /// No description provided for @settingsScreen_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsScreen_title;

  /// No description provided for @settingsScreen_account_title.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsScreen_account_title;

  /// No description provided for @settingsScreen_account_my_preference.
  ///
  /// In en, this message translates to:
  /// **'My Preference'**
  String get settingsScreen_account_my_preference;

  /// No description provided for @settingsScreen_account_my_profile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get settingsScreen_account_my_profile;

  /// No description provided for @settingsScreen_account_change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get settingsScreen_account_change_password;

  /// No description provided for @settingsScreen_favourite_title.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get settingsScreen_favourite_title;

  /// No description provided for @settingsScreen_favourite_surgeon.
  ///
  /// In en, this message translates to:
  /// **'Favorite Surgeons'**
  String get settingsScreen_favourite_surgeon;

  /// No description provided for @settingsScreen_favourite_hospital.
  ///
  /// In en, this message translates to:
  /// **'Favorite Hospitals'**
  String get settingsScreen_favourite_hospital;

  /// No description provided for @settingsScreen_favourite_procedure.
  ///
  /// In en, this message translates to:
  /// **'Favorite Procedures'**
  String get settingsScreen_favourite_procedure;

  /// No description provided for @settingsScreen_reports_title.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get settingsScreen_reports_title;

  /// No description provided for @settingsScreen_reports_backorder_report.
  ///
  /// In en, this message translates to:
  /// **'BackOrder Report'**
  String get settingsScreen_reports_backorder_report;

  /// No description provided for @settingsScreen_reports_sales_snapshot.
  ///
  /// In en, this message translates to:
  /// **'Sales Snapshot'**
  String get settingsScreen_reports_sales_snapshot;

  /// No description provided for @settingsScreen_general_title.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsScreen_general_title;

  /// No description provided for @settingsScreen_general_manage_templates.
  ///
  /// In en, this message translates to:
  /// **'Manage Templates'**
  String get settingsScreen_general_manage_templates;

  /// No description provided for @settingsScreen_general_technique_library.
  ///
  /// In en, this message translates to:
  /// **'Technique Library'**
  String get settingsScreen_general_technique_library;

  /// No description provided for @settingsScreen_general_announcement.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get settingsScreen_general_announcement;

  /// No description provided for @settingsScreen_general_company_directory.
  ///
  /// In en, this message translates to:
  /// **'Company Directory'**
  String get settingsScreen_general_company_directory;

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

  /// No description provided for @my_preferenceScreen_auto_capture_title.
  ///
  /// In en, this message translates to:
  /// **'Auto Capture'**
  String get my_preferenceScreen_auto_capture_title;

  /// No description provided for @my_preferenceScreen_auto_capture_info.
  ///
  /// In en, this message translates to:
  /// **'Enable auto-capture for continuous barcode scanning or disable it for point-and-shoot mode.'**
  String get my_preferenceScreen_auto_capture_info;

  /// No description provided for @myPreferenceScreen_removeDialog_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this distributor? You will be logged out and need to enter a distributor code to log in again.'**
  String get myPreferenceScreen_removeDialog_message;

  /// A message with a distributor name
  ///
  /// In en, this message translates to:
  /// **'You’re logged in as a {distributor} representative. Click Delete to remove the distributor.'**
  String myPreferenceScreen_distributor_info(String distributor);

  /// No description provided for @changePasswordScreen_currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get changePasswordScreen_currentPassword;

  /// No description provided for @changePasswordScreen_newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get changePasswordScreen_newPassword;

  /// No description provided for @changePasswordScreen_confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get changePasswordScreen_confirmPassword;

  /// No description provided for @changePasswordScreen_currentPassword_validation.
  ///
  /// In en, this message translates to:
  /// **'Please enter current password'**
  String get changePasswordScreen_currentPassword_validation;

  /// No description provided for @changePasswordScreen_newPassword_validation.
  ///
  /// In en, this message translates to:
  /// **'Please enter new password'**
  String get changePasswordScreen_newPassword_validation;

  /// No description provided for @changePasswordScreen_confirmPassword_validation.
  ///
  /// In en, this message translates to:
  /// **'Please enter confirm password'**
  String get changePasswordScreen_confirmPassword_validation;

  /// No description provided for @changePasswordScreen_password_match.
  ///
  /// In en, this message translates to:
  /// **'Password does not match'**
  String get changePasswordScreen_password_match;

  /// No description provided for @changePasswordScreen_success_message.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully.'**
  String get changePasswordScreen_success_message;

  /// No description provided for @myProfileScreen_personal_info_title.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get myProfileScreen_personal_info_title;

  /// No description provided for @myProfileScreen_user_name_hint.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get myProfileScreen_user_name_hint;

  /// No description provided for @myProfileScreen_first_name_hint.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get myProfileScreen_first_name_hint;

  /// No description provided for @myProfileScreen_last_name_hint.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get myProfileScreen_last_name_hint;

  /// No description provided for @myProfileScreen_group_hint.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get myProfileScreen_group_hint;

  /// No description provided for @myProfileScreen_email_hint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get myProfileScreen_email_hint;

  /// No description provided for @myProfileScreen_wwid_hint.
  ///
  /// In en, this message translates to:
  /// **'WWId'**
  String get myProfileScreen_wwid_hint;

  /// No description provided for @myProfileScreen_address_title.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get myProfileScreen_address_title;

  /// No description provided for @myProfileScreen_address_hint.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get myProfileScreen_address_hint;

  /// No description provided for @myProfileScreen_city_hint.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get myProfileScreen_city_hint;

  /// No description provided for @myProfileScreen_state_hint.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get myProfileScreen_state_hint;

  /// No description provided for @myProfileScreen_zip_hint.
  ///
  /// In en, this message translates to:
  /// **'Zip'**
  String get myProfileScreen_zip_hint;

  /// No description provided for @myProfileScreen_searchStates.
  ///
  /// In en, this message translates to:
  /// **'Search States'**
  String get myProfileScreen_searchStates;

  /// No description provided for @myProfileScreen_zip_invalidError.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid zip'**
  String get myProfileScreen_zip_invalidError;

  /// No description provided for @myProfileScreen_contact_info_title.
  ///
  /// In en, this message translates to:
  /// **'Contact Info'**
  String get myProfileScreen_contact_info_title;

  /// No description provided for @myProfileScreen_cell_number_hint.
  ///
  /// In en, this message translates to:
  /// **'Cell Number'**
  String get myProfileScreen_cell_number_hint;

  /// No description provided for @myProfileScreen_phone_number_hint.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get myProfileScreen_phone_number_hint;

  /// No description provided for @myProfileScreen_fax_number_hint.
  ///
  /// In en, this message translates to:
  /// **'Fax Number'**
  String get myProfileScreen_fax_number_hint;

  /// No description provided for @myProfileScreen_account_number_hint.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get myProfileScreen_account_number_hint;

  /// No description provided for @myProfileScreen_contact_info_hint.
  ///
  /// In en, this message translates to:
  /// **'Contact Info'**
  String get myProfileScreen_contact_info_hint;

  /// No description provided for @myProfileScreen_cell_number_invalidError.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid cell number'**
  String get myProfileScreen_cell_number_invalidError;

  /// No description provided for @myProfileScreen_phone_number_invalidError.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid phone number'**
  String get myProfileScreen_phone_number_invalidError;

  /// No description provided for @myProfileScreen_fax_number_invalidError.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid fax number'**
  String get myProfileScreen_fax_number_invalidError;

  /// No description provided for @favouriteSurgeonScreen_title.
  ///
  /// In en, this message translates to:
  /// **'Favorite Surgeons'**
  String get favouriteSurgeonScreen_title;

  /// No description provided for @favouriteSurgeonScreen_nickname.
  ///
  /// In en, this message translates to:
  /// **'Nick Name'**
  String get favouriteSurgeonScreen_nickname;

  /// No description provided for @favouriteSurgeonScreen_search_surgeon.
  ///
  /// In en, this message translates to:
  /// **'Search surgeon'**
  String get favouriteSurgeonScreen_search_surgeon;

  /// No description provided for @favouriteHospitalScreen_title.
  ///
  /// In en, this message translates to:
  /// **'Favorite Hospitals'**
  String get favouriteHospitalScreen_title;

  /// No description provided for @favouriteHospitalScreen_nickname.
  ///
  /// In en, this message translates to:
  /// **'Nick Name'**
  String get favouriteHospitalScreen_nickname;

  /// No description provided for @favouriteHospitalScreen_search_hospital.
  ///
  /// In en, this message translates to:
  /// **'Search hospital'**
  String get favouriteHospitalScreen_search_hospital;

  /// No description provided for @favouriteProcedureScreen_title.
  ///
  /// In en, this message translates to:
  /// **'Favorite Procedures'**
  String get favouriteProcedureScreen_title;

  /// No description provided for @favouriteProcedureScreen_procedure_name.
  ///
  /// In en, this message translates to:
  /// **'Procedure Name'**
  String get favouriteProcedureScreen_procedure_name;

  /// No description provided for @favouriteProcedureScreen_nickname.
  ///
  /// In en, this message translates to:
  /// **'Nick Name'**
  String get favouriteProcedureScreen_nickname;

  /// No description provided for @favouriteProcedureScreen_select_procedure.
  ///
  /// In en, this message translates to:
  /// **'Select procedure'**
  String get favouriteProcedureScreen_select_procedure;

  /// No description provided for @profilesScreen_title.
  ///
  /// In en, this message translates to:
  /// **'Profiles'**
  String get profilesScreen_title;

  /// No description provided for @profilesScreen_hospital_title.
  ///
  /// In en, this message translates to:
  /// **'Hospitals'**
  String get profilesScreen_hospital_title;

  /// No description provided for @profilesScreen_surgeons_title.
  ///
  /// In en, this message translates to:
  /// **'Surgeons'**
  String get profilesScreen_surgeons_title;

  /// No description provided for @profilesScreen_hospitals_no_data_message.
  ///
  /// In en, this message translates to:
  /// **'No hospitals Found'**
  String get profilesScreen_hospitals_no_data_message;

  /// No description provided for @profilesScreen_surgeons_no_data_message.
  ///
  /// In en, this message translates to:
  /// **'No surgeons Found'**
  String get profilesScreen_surgeons_no_data_message;

  /// No description provided for @hospitalProfilesScreen_inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get hospitalProfilesScreen_inventory;

  /// No description provided for @hospitalProfilesScreen_sales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get hospitalProfilesScreen_sales;

  /// No description provided for @hospitalProfilesScreen_hospital_contact.
  ///
  /// In en, this message translates to:
  /// **'Hospital Contact'**
  String get hospitalProfilesScreen_hospital_contact;

  /// No description provided for @hospitalProfilesScreen_general_tab.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get hospitalProfilesScreen_general_tab;

  /// No description provided for @hospitalProfilesScreen_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get hospitalProfilesScreen_notes;

  /// No description provided for @hospitalProfilesScreen_contact_info_tab.
  ///
  /// In en, this message translates to:
  /// **'Contact Info'**
  String get hospitalProfilesScreen_contact_info_tab;

  /// No description provided for @hospitalProfilesScreen_associated_surgeons_tab.
  ///
  /// In en, this message translates to:
  /// **'Associated Surgeons'**
  String get hospitalProfilesScreen_associated_surgeons_tab;

  /// No description provided for @hospitalProfilesScreen_general_tab_contacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get hospitalProfilesScreen_general_tab_contacts;

  /// No description provided for @hospitalProfilesScreen_general_tab_role.
  ///
  /// In en, this message translates to:
  /// **'Role: '**
  String get hospitalProfilesScreen_general_tab_role;

  /// No description provided for @hospitalProfilesScreen_general_tab_type.
  ///
  /// In en, this message translates to:
  /// **'Type: '**
  String get hospitalProfilesScreen_general_tab_type;

  /// No description provided for @hospitalProfilesScreen_general_tab_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone: '**
  String get hospitalProfilesScreen_general_tab_phone;

  /// No description provided for @hospitalProfilesScreen_general_tab_cell.
  ///
  /// In en, this message translates to:
  /// **'Cell: '**
  String get hospitalProfilesScreen_general_tab_cell;

  /// No description provided for @hospitalProfilesScreen_general_tab_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes:'**
  String get hospitalProfilesScreen_general_tab_notes;

  /// No description provided for @hospitalProfilesScreen_no_data_message.
  ///
  /// In en, this message translates to:
  /// **'No hospitals details found'**
  String get hospitalProfilesScreen_no_data_message;

  /// No description provided for @hospitalContactsScreen_title.
  ///
  /// In en, this message translates to:
  /// **'Hospital Contacts'**
  String get hospitalContactsScreen_title;

  /// No description provided for @hospitalContactsScreen_name_hint.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get hospitalContactsScreen_name_hint;

  /// No description provided for @hospitalContactsScreen_email_hint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get hospitalContactsScreen_email_hint;

  /// No description provided for @hospitalContactsScreen_add_contact_button.
  ///
  /// In en, this message translates to:
  /// **'Add Contact'**
  String get hospitalContactsScreen_add_contact_button;

  /// No description provided for @hospitalContactsScreen_no_data_message.
  ///
  /// In en, this message translates to:
  /// **'No hospitals contacts Found, please add new'**
  String get hospitalContactsScreen_no_data_message;

  /// No description provided for @hospitalContactsScreen_name_validation.
  ///
  /// In en, this message translates to:
  /// **'Please enter name'**
  String get hospitalContactsScreen_name_validation;

  /// No description provided for @hospitalContactsScreen_email_validation.
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get hospitalContactsScreen_email_validation;

  /// No description provided for @hospitalContactsScreen_errorInvalidEmail_message.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid email'**
  String get hospitalContactsScreen_errorInvalidEmail_message;

  /// No description provided for @hospitalContactsScreen_deleteContactsDialog_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to delete this contact?'**
  String get hospitalContactsScreen_deleteContactsDialog_message;

  /// No description provided for @hospitalNotesScreen_title.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get hospitalNotesScreen_title;

  /// No description provided for @surgeonProfilesScreen_no_data_message.
  ///
  /// In en, this message translates to:
  /// **'No surgeon details found'**
  String get surgeonProfilesScreen_no_data_message;

  /// No description provided for @surgeonProfilesScreen_sales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get surgeonProfilesScreen_sales;

  /// No description provided for @surgeonProfilesScreen_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get surgeonProfilesScreen_notes;

  /// No description provided for @surgeonProfilesScreen_training_tab.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get surgeonProfilesScreen_training_tab;

  /// No description provided for @surgeonProfilesScreen_events_tab.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get surgeonProfilesScreen_events_tab;

  /// No description provided for @surgeonProfilesScreen_training_underGraduate.
  ///
  /// In en, this message translates to:
  /// **'UnderGraduate'**
  String get surgeonProfilesScreen_training_underGraduate;

  /// No description provided for @surgeonProfilesScreen_training_medical_school.
  ///
  /// In en, this message translates to:
  /// **'Medical School'**
  String get surgeonProfilesScreen_training_medical_school;

  /// No description provided for @surgeonProfilesScreen_training_residency.
  ///
  /// In en, this message translates to:
  /// **'Residency'**
  String get surgeonProfilesScreen_training_residency;

  /// No description provided for @surgeonProfilesScreen_training_fellowship.
  ///
  /// In en, this message translates to:
  /// **'Fellowship'**
  String get surgeonProfilesScreen_training_fellowship;

  /// No description provided for @surgeonProfilesScreen_training_notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get surgeonProfilesScreen_training_notes;
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
