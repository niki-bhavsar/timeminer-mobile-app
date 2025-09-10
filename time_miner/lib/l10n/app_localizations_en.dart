// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Compass Software';

  @override
  String get action_next => 'Next';

  @override
  String get action_ok => 'Ok';

  @override
  String get action_cancel => 'Cancel';

  @override
  String get action_yes => 'Yes';

  @override
  String get action_no => 'No';

  @override
  String get action_update => 'Update';

  @override
  String get action_edit => 'Edit';

  @override
  String get action_delete => 'Delete';

  @override
  String get action_try_again => 'Try Again';

  @override
  String get stateView_message => 'Something went wrong!';

  @override
  String get no_data_message => 'No data Found';

  @override
  String get back_button_title => 'Back';

  @override
  String get distributorCodeScreen_codeInput_title => 'Enter the Distributor Code';

  @override
  String get distributorCodeScreen_codeInput_hint => 'Code';

  @override
  String get distributorCodeScreen_codeInput_emptyError => 'Please enter code';

  @override
  String get distributorCodeScreen_invalidCode_message => 'The code you entered is invalid.';

  @override
  String get loginScreen_title => 'Login';

  @override
  String get loginScreen_subtitle => 'Please login to your Account';

  @override
  String get loginScreen_login_action => 'Login';

  @override
  String get loginScreen_emailInput_hint => 'Email';

  @override
  String get loginScreen_passwordInput_hint => 'Password';

  @override
  String get loginScreen_emailInput_emptyError => 'Please enter email';

  @override
  String get loginScreen_passwordInput_emptyError => 'Please enter password';

  @override
  String get loginScreen_invalidCredential_message =>
      'The email or password you entered is incorrect.';

  @override
  String get bottomMenuScreen_tabSchedule_title => 'Schedule';

  @override
  String get bottomMenuScreen_tabProfiles_title => 'Profiles';

  @override
  String get bottomMenuScreen_tabSales_title => 'Sales';

  @override
  String get bottomMenuScreen_tabSettings_title => 'Settings';

  @override
  String get tryAgain_button_title => 'Try Again';

  @override
  String get announcementScreen_title => 'Announcements';

  @override
  String get announcementScreen_noData_message => 'No Announcements Found';

  @override
  String get announcementScreen_detail_title => 'Announcement Details';

  @override
  String get techniqueLibraryScreen_title => 'Technique Library';

  @override
  String get techniqueLibraryScreen_noData_message => 'No Technique Library Found';

  @override
  String get techniqueLibraryScreen_search_hint => 'Search';

  @override
  String get techniqueLibraryScreen_anatomy_title => 'Anatomy';

  @override
  String get techniqueLibraryScreen_system_title => 'System';

  @override
  String get techniqueLibraryDetailScreen_failed_document_message =>
      'Failed to load the document. Please try again later';

  @override
  String get techniqueLibraryDetailScreen_failed_alert_title => 'Failed';

  @override
  String get templateListScreen_title => 'Templates List';

  @override
  String get createNewTemplate_title => 'Add Template';

  @override
  String get editTemplate_title => 'Edit Template';

  @override
  String get createEditTemplate_nameInput_hint => 'Template Name';

  @override
  String get createEditTemplate_nameInput_emptyError => 'Please enter template name';

  @override
  String get createEditTemplate_Implants_segment_title => 'Implants';

  @override
  String get createEditTemplate_Instruments_segment_title => 'Instruments';

  @override
  String get createEditTemplate_empty_implant_instruments_title => 'Unknown Manufacturer';

  @override
  String get createEditTemplate_empty_implant_instruments_no_data => 'No data found';

  @override
  String get createEditTemplate_implant_noData_message => 'No Data  Found';

  @override
  String get template_filter_categories_title => 'Filters';

  @override
  String get template_kit_detail_title => 'Kit Details';

  @override
  String get template_kit_Unknown_Value => 'Unknown Value';

  @override
  String get template_category_dropdown_title => 'Choose an Item';

  @override
  String get template_category_dropdown_Selected_title => 'Selected';

  @override
  String get template_category_dropdown_All_title => 'All';

  @override
  String get companydirectoryscreen_title => 'Company Directory';

  @override
  String get companydirectoryScreen_noData_message => 'No Company Directory Found';

  @override
  String get companydirectory_role_title => 'Role : ';

  @override
  String get companydirectory_region_title => 'Region : ';

  @override
  String get companydirectory_office_title => 'Office : ';

  @override
  String get companydirectory_phone_title => 'Phone : ';

  @override
  String get companydirectory_groupname_title => 'Group : ';

  @override
  String get settingsScreen_title => 'Settings';

  @override
  String get settingsScreen_account_title => 'Account';

  @override
  String get settingsScreen_account_my_preference => 'My Preference';

  @override
  String get settingsScreen_account_my_profile => 'My Profile';

  @override
  String get settingsScreen_account_change_password => 'Change Password';

  @override
  String get settingsScreen_favourite_title => 'Favorite';

  @override
  String get settingsScreen_favourite_surgeon => 'Favorite Surgeons';

  @override
  String get settingsScreen_favourite_hospital => 'Favorite Hospitals';

  @override
  String get settingsScreen_favourite_procedure => 'Favorite Procedures';

  @override
  String get settingsScreen_reports_title => 'Reports';

  @override
  String get settingsScreen_reports_backorder_report => 'BackOrder Report';

  @override
  String get settingsScreen_reports_sales_snapshot => 'Sales Snapshot';

  @override
  String get settingsScreen_general_title => 'General';

  @override
  String get settingsScreen_general_manage_templates => 'Manage Templates';

  @override
  String get settingsScreen_general_technique_library => 'Technique Library';

  @override
  String get settingsScreen_general_announcement => 'Announcements';

  @override
  String get settingsScreen_general_company_directory => 'Company Directory';

  @override
  String get settingsScreen_general_logout => 'Logout';

  @override
  String get settingsScreen_logoutDialog_message => 'Are you sure you want to logout?';

  @override
  String get my_preferenceScreen_auto_capture_title => 'Auto Capture';

  @override
  String get my_preferenceScreen_auto_capture_info =>
      'Enable auto-capture for continuous barcode scanning or disable it for point-and-shoot mode.';

  @override
  String get myPreferenceScreen_removeDialog_message =>
      'Are you sure you want to remove this distributor? You will be logged out and need to enter a distributor code to log in again.';

  @override
  String myPreferenceScreen_distributor_info(String distributor) {
    return 'You’re logged in as a $distributor representative. Click Delete to remove the distributor.';
  }

  @override
  String get changePasswordScreen_currentPassword => 'Current Password';

  @override
  String get changePasswordScreen_newPassword => 'New Password';

  @override
  String get changePasswordScreen_confirmPassword => 'Confirm Password';

  @override
  String get changePasswordScreen_currentPassword_validation => 'Please enter current password';

  @override
  String get changePasswordScreen_newPassword_validation => 'Please enter new password';

  @override
  String get changePasswordScreen_confirmPassword_validation => 'Please enter confirm password';

  @override
  String get changePasswordScreen_password_match => 'Password does not match';

  @override
  String get changePasswordScreen_success_message => 'Password updated successfully.';

  @override
  String get myProfileScreen_personal_info_title => 'Personal Info';

  @override
  String get myProfileScreen_user_name_hint => 'Username';

  @override
  String get myProfileScreen_first_name_hint => 'First Name';

  @override
  String get myProfileScreen_last_name_hint => 'Last Name';

  @override
  String get myProfileScreen_group_hint => 'Group';

  @override
  String get myProfileScreen_email_hint => 'Email';

  @override
  String get myProfileScreen_wwid_hint => 'WWId';

  @override
  String get myProfileScreen_address_title => 'Address';

  @override
  String get myProfileScreen_address_hint => 'Address';

  @override
  String get myProfileScreen_city_hint => 'City';

  @override
  String get myProfileScreen_state_hint => 'State';

  @override
  String get myProfileScreen_zip_hint => 'Zip';

  @override
  String get myProfileScreen_searchStates => 'Search States';

  @override
  String get myProfileScreen_zip_invalidError => 'Please enter valid zip';

  @override
  String get myProfileScreen_contact_info_title => 'Contact Info';

  @override
  String get myProfileScreen_cell_number_hint => 'Cell Number';

  @override
  String get myProfileScreen_phone_number_hint => 'Phone Number';

  @override
  String get myProfileScreen_fax_number_hint => 'Fax Number';

  @override
  String get myProfileScreen_account_number_hint => 'Account Number';

  @override
  String get myProfileScreen_contact_info_hint => 'Contact Info';

  @override
  String get myProfileScreen_cell_number_invalidError => 'Please enter valid cell number';

  @override
  String get myProfileScreen_phone_number_invalidError => 'Please enter valid phone number';

  @override
  String get myProfileScreen_fax_number_invalidError => 'Please enter valid fax number';

  @override
  String get favouriteSurgeonScreen_title => 'Favorite Surgeons';

  @override
  String get favouriteSurgeonScreen_nickname => 'Nick Name';

  @override
  String get favouriteSurgeonScreen_search_surgeon => 'Search surgeon';

  @override
  String get favouriteHospitalScreen_title => 'Favorite Hospitals';

  @override
  String get favouriteHospitalScreen_nickname => 'Nick Name';

  @override
  String get favouriteHospitalScreen_search_hospital => 'Search hospital';

  @override
  String get favouriteProcedureScreen_title => 'Favorite Procedures';

  @override
  String get favouriteProcedureScreen_procedure_name => 'Procedure Name';

  @override
  String get favouriteProcedureScreen_nickname => 'Nick Name';

  @override
  String get favouriteProcedureScreen_select_procedure => 'Select procedure';

  @override
  String get profilesScreen_title => 'Profiles';

  @override
  String get profilesScreen_hospital_title => 'Hospitals';

  @override
  String get profilesScreen_surgeons_title => 'Surgeons';

  @override
  String get profilesScreen_hospitals_no_data_message => 'No hospitals Found';

  @override
  String get profilesScreen_surgeons_no_data_message => 'No surgeons Found';

  @override
  String get hospitalProfilesScreen_inventory => 'Inventory';

  @override
  String get hospitalProfilesScreen_sales => 'Sales';

  @override
  String get hospitalProfilesScreen_hospital_contact => 'Hospital Contact';

  @override
  String get hospitalProfilesScreen_general_tab => 'General';

  @override
  String get hospitalProfilesScreen_notes => 'Notes';

  @override
  String get hospitalProfilesScreen_contact_info_tab => 'Contact Info';

  @override
  String get hospitalProfilesScreen_associated_surgeons_tab => 'Associated Surgeons';

  @override
  String get hospitalProfilesScreen_general_tab_contacts => 'Contacts';

  @override
  String get hospitalProfilesScreen_general_tab_role => 'Role: ';

  @override
  String get hospitalProfilesScreen_general_tab_type => 'Type: ';

  @override
  String get hospitalProfilesScreen_general_tab_phone => 'Phone: ';

  @override
  String get hospitalProfilesScreen_general_tab_cell => 'Cell: ';

  @override
  String get hospitalProfilesScreen_general_tab_notes => 'Notes:';

  @override
  String get hospitalProfilesScreen_no_data_message => 'No hospitals details found';

  @override
  String get hospitalContactsScreen_title => 'Hospital Contacts';

  @override
  String get hospitalContactsScreen_name_hint => 'Name';

  @override
  String get hospitalContactsScreen_email_hint => 'Email';

  @override
  String get hospitalContactsScreen_add_contact_button => 'Add Contact';

  @override
  String get hospitalContactsScreen_no_data_message =>
      'No hospitals contacts Found, please add new';

  @override
  String get hospitalContactsScreen_name_validation => 'Please enter name';

  @override
  String get hospitalContactsScreen_email_validation => 'Please enter email';

  @override
  String get hospitalContactsScreen_errorInvalidEmail_message => 'Please enter valid email';

  @override
  String get hospitalContactsScreen_deleteContactsDialog_message =>
      'Are you sure to delete this contact?';

  @override
  String get hospitalNotesScreen_title => 'Notes';

  @override
  String get surgeonProfilesScreen_no_data_message => 'No surgeon details found';

  @override
  String get surgeonProfilesScreen_sales => 'Sales';

  @override
  String get surgeonProfilesScreen_notes => 'Notes';

  @override
  String get surgeonProfilesScreen_training_tab => 'Training';

  @override
  String get surgeonProfilesScreen_events_tab => 'Events';

  @override
  String get surgeonProfilesScreen_training_underGraduate => 'UnderGraduate';

  @override
  String get surgeonProfilesScreen_training_medical_school => 'Medical School';

  @override
  String get surgeonProfilesScreen_training_residency => 'Residency';

  @override
  String get surgeonProfilesScreen_training_fellowship => 'Fellowship';

  @override
  String get surgeonProfilesScreen_training_notes => 'Notes';
}
