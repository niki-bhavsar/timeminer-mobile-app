import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_miner/data/entity/sync_contacts_entity.dart';
import 'package:time_miner/data/repository/contact_repository.dart';
import 'package:time_miner/data/service/model/call_result.dart';
import 'package:time_miner/screens/contacts/model/contact_selection_model.dart';
import 'package:time_miner/screens/contacts/state/contact_sync_state.dart';

class ContactCubit extends Cubit<ContactState> {
  final ContactRepository contactRepository;

  ContactCubit({required this.contactRepository}) : super(const ContactState());

  Future<void> fetchContacts() async {
    emit(state.copyWith(status: ContactStatus.loading));

    var status = await Permission.contacts.request();

    if (!status.isGranted) {
      emit(state.copyWith(status: ContactStatus.permissionDenied));
      return;
    }

    try {
      Iterable<Contact> contacts = await ContactsService.getContacts(
        withThumbnails: false,
      );
      final contactSelections = contacts
          .map((c) => ContactSelection(contact: c))
          .toList();

      emit(
        state.copyWith(
          status: ContactStatus.loaded,
          contacts: contactSelections,
          filteredContacts: contactSelections,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: ContactStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void toggleSelection(String contactId, bool isSelected) {
    final updatedContacts = state.contacts.map((c) {
      if (c.contact.identifier == contactId) {
        return ContactSelection(contact: c.contact, isSelected: isSelected);
      }
      return c;
    }).toList();

    final updatedFiltered = updatedContacts
        .where(
          (c) =>
              c.contact.displayName?.toLowerCase().contains(
                state.searchQuery.toLowerCase(),
              ) ??
              false,
        )
        .toList();

    emit(
      state.copyWith(
        contacts: updatedContacts,
        filteredContacts: updatedFiltered,
      ),
    );
  }

  void search(String query) {
    final filtered = state.contacts.where((selection) {
      final name = selection.contact.displayName?.toLowerCase() ?? '';
      final phone = selection.contact.phones?.isNotEmpty == true
          ? selection.contact.phones!.first.value?.toLowerCase() ?? ''
          : '';
      return name.contains(query.toLowerCase()) ||
          phone.contains(query.toLowerCase());
    }).toList();

    emit(state.copyWith(searchQuery: query, filteredContacts: filtered));
  }

  Future<void> syncContacts() async {
    emit(state.copyWith(status: ContactStatus.syncing));

    final allContacts = state.contacts.toList();
    final List<Map<String, dynamic>> formatted = allContacts.map((s) {
      final contact = s.contact;
      List<String> phoneNumbers = contact.phones?.isNotEmpty == true
          ? contact.phones!.map((p) => p.value ?? '').toList()
          : [];

      String? email = contact.emails?.isNotEmpty == true
          ? contact.emails!.first.value
          : '';

      return {
        "name": contact.displayName ?? '',
        "phone_numbers": phoneNumbers,
        "email": email,
        "mine_status": s.isSelected,
      };
    }).toList();

    // Split contacts into chunks of 50
    const chunkSize = 500;
    final chunks = <List<Map<String, dynamic>>>[];
    for (var i = 0; i < formatted.length; i += chunkSize) {
      chunks.add(
        formatted.sublist(
          i,
          i + chunkSize > formatted.length ? formatted.length : i + chunkSize,
        ),
      );
    }

    // Sync contacts in chunks
    final List<FailedContact> allFailedContacts = [];
    bool hasError = false;
    String? errorMessage;

    for (var i = 0; i < chunks.length; i++) {
      final chunk = chunks[i];
      final CallResult<SyncContactsEntity> response = await contactRepository
          .syncContacts(contacts: chunk);

      if (response is Success<SyncContactsEntity>) {
        final syncResult = response.data;
        final failedContacts = syncResult.data?.failed ?? [];
        allFailedContacts.addAll(failedContacts);
      } else if (response is Failure<SyncContactsEntity>) {
        hasError = true;
        errorMessage = response.cause;
        break; // Stop syncing if there's an error
      }
    }

    if (hasError) {
      emit(
        state.copyWith(status: ContactStatus.error, errorMessage: errorMessage),
      );
    } else if (allFailedContacts.isNotEmpty) {
      emit(
        state.copyWith(
          status: ContactStatus.success,
          failedContacts: allFailedContacts,
        ),
      );
    } else {
      emit(state.copyWith(status: ContactStatus.success));
    }
  }
}
