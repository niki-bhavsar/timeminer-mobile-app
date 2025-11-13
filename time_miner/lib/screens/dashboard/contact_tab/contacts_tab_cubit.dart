import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/entity/contacts_entity.dart';
import '../../../data/entity/sync_contacts_entity.dart';
import '../../../data/repository/contact_repository.dart';
import '../../../data/service/model/call_result.dart';
import 'bloc/contacts_tab_state.dart';

class ContactsTabCubit extends Cubit<ContactsTabState> {
  final ContactRepository contactRepository;

  // Synced contacts (from API)
  List<ContactItem> syncedContacts = [];
  // Phone contacts from device
  List<ContactItem> phoneContactItems = [];
  // Combined list of all contacts
  List<ContactItem> allContactItems = [];
  // Unsynced contacts (phone contacts not in API)
  List<ContactItem> unsyncedContacts = [];
  // Store original mineStatus to track changes
  Map<int, bool> originalMineStatusMap = {};

  ContactsTabCubit({required this.contactRepository})
    : super(ContactsTabInitialState());

  Future<void> fetchContactsData() async {
    emit(ContactsTabLoadingState());

    // Fetch contacts from API
    final result = await contactRepository.getContacts();
    if (result is Failure<ContactsEntity>) {
      emit(
        ContactsTabErrorState(
          error: result.cause,
          isAuthError: result.isAuthError(),
        ),
      );
    } else if (result is Success<ContactsEntity>) {
      print(result.data.contactItems);
      syncedContacts = result.data.contactItems;

      // Fetch phone contacts and merge
      await _fetchPhoneContacts();

      _mergeContacts();
      emit(ContactsTabResultState());
    }
  }

  Future<void> _fetchPhoneContacts() async {
    var status = await Permission.contacts.request();

    if (status.isGranted) {
      try {
        Iterable<Contact> contacts = await ContactsService.getContacts(
          withThumbnails: false,
        );

        phoneContactItems = contacts.map((contact) {
          final phoneNumbers = contact.phones?.isNotEmpty == true
              ? contact.phones!
                    .map((p) => ContactPhoneNumber(phoneNumber: p.value ?? ''))
                    .toList()
              : <ContactPhoneNumber>[];

          return ContactItem(
            name: contact.displayName ?? 'No Name',
            email: contact.emails?.isNotEmpty == true
                ? contact.emails!.first.value
                : null,
            phoneNumbers: phoneNumbers,
            mineStatus: false, // Default to false for phone contacts
          );
        }).toList();
      } catch (e) {
        print("Error fetching phone contacts: $e");
        phoneContactItems = [];
      }
    } else {
      phoneContactItems = [];
    }
  }

  bool _isDuplicate(ContactItem phoneContact, ContactItem apiContact) {
    // Check by phone number (exact match)
    if (phoneContact.phoneNumbers != null &&
        phoneContact.phoneNumbers!.isNotEmpty &&
        apiContact.phoneNumbers != null &&
        apiContact.phoneNumbers!.isNotEmpty) {
      for (var phonePhone in phoneContact.phoneNumbers!) {
        if (phonePhone.phoneNumber == null || phonePhone.phoneNumber!.isEmpty)
          continue;

        for (var apiPhone in apiContact.phoneNumbers!) {
          if (apiPhone.phoneNumber == null || apiPhone.phoneNumber!.isEmpty)
            continue;

          // Check if phone numbers match exactly
          if (phonePhone.phoneNumber == apiPhone.phoneNumber) {
            return true;
          }
        }
      }
    }

    // Check by email (exact match)
    if (phoneContact.email != null &&
        phoneContact.email!.isNotEmpty &&
        apiContact.email != null &&
        apiContact.email!.isNotEmpty &&
        phoneContact.email == apiContact.email) {
      return true;
    }

    // Check by name (exact match)
    if (phoneContact.name != null &&
        phoneContact.name!.isNotEmpty &&
        apiContact.name != null &&
        apiContact.name!.isNotEmpty &&
        phoneContact.name == apiContact.name) {
      // If names match and at least one has matching phone or email, it's a duplicate
      if ((phoneContact.email != null &&
              apiContact.email != null &&
              phoneContact.email == apiContact.email) ||
          (phoneContact.phoneNumbers != null &&
              phoneContact.phoneNumbers!.isNotEmpty &&
              apiContact.phoneNumbers != null &&
              apiContact.phoneNumbers!.isNotEmpty)) {
        return true;
      }
    }

    return false;
  }

  void _mergeContacts() {
    // Store original mineStatus for synced contacts
    originalMineStatusMap.clear();
    for (var i = 0; i < syncedContacts.length; i++) {
      originalMineStatusMap[syncedContacts[i].id ?? i] =
          syncedContacts[i].mineStatus;
    }

    unsyncedContacts = [];

    // Check each phone contact against all API contacts
    for (var phoneContact in phoneContactItems) {
      bool isDuplicate = false;

      // Check if this phone contact matches any API contact
      for (var apiContact in syncedContacts) {
        if (_isDuplicate(phoneContact, apiContact)) {
          isDuplicate = true;
          break;
        }
      }

      // Only add phone contact to unsynced if it's not a duplicate
      if (!isDuplicate) {
        unsyncedContacts.add(phoneContact);
      }
    }

    // Combined list for backward compatibility
    allContactItems = [...syncedContacts, ...unsyncedContacts];
  }

  syncContactsData() async {
    emit(ContactsTabLoadingState());

    // Collect contacts to sync
    final List<Map<String, dynamic>> contactsToSync = [];

    // Add all unsynced contacts
    for (var contact in unsyncedContacts) {
      final phoneNumbers =
          contact.phoneNumbers != null && contact.phoneNumbers!.isNotEmpty
          ? contact.phoneNumbers!
                .map((p) => p.phoneNumber ?? '')
                .where((p) => p.isNotEmpty)
                .toList()
          : <String>[];

      final contactData = {
        "name": contact.name ?? '',
        "phone_numbers": phoneNumbers,
        "email": contact.email ?? '',
        "mine_status": contact.mineStatus,
      };
      contactsToSync.add(contactData);
    }

    // Add synced contacts where mineStatus has changed
    for (var contact in syncedContacts) {
      final originalStatus = originalMineStatusMap[contact.id];
      if (originalStatus != null && originalStatus != contact.mineStatus) {
        final phoneNumbers =
            contact.phoneNumbers != null && contact.phoneNumbers!.isNotEmpty
            ? contact.phoneNumbers!
                  .map((p) => p.phoneNumber ?? '')
                  .where((p) => p.isNotEmpty)
                  .toList()
            : <String>[];

        final contactData = {
          "name": contact.name ?? '',
          "phone_numbers": phoneNumbers,
          "email": contact.email ?? '',
          "mine_status": contact.mineStatus,
        };
        contactsToSync.add(contactData);
      }
    }

    if (contactsToSync.isEmpty) {
      // No contacts to sync
      emit(ContactsTabResultState());
      return;
    }

    // Sync all contacts at once
    final CallResult<SyncContactsEntity> result = await contactRepository
        .syncContacts(contacts: contactsToSync);

    if (result is Failure<SyncContactsEntity>) {
      emit(
        ContactsTabErrorState(
          error: result.cause,
          isAuthError: result.isAuthError(),
        ),
      );
    } else if (result is Success<SyncContactsEntity>) {
      // Refresh contacts after sync
      await fetchContactsData();

      // Emit success state after fetching updated contacts
      final syncResult = result.data;
      final failedContacts = syncResult.data?.failed ?? [];
      emit(
        ContactsTabSyncSuccessState(
          message: syncResult.message.isNotEmpty
              ? syncResult.message
              : 'Contacts synced successfully!',
          failedContacts: failedContacts.isNotEmpty ? failedContacts : null,
        ),
      );
    }
  }
}
