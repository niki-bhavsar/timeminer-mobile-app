import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_miner/data/entity/base_entity.dart';
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
      return {
        "name": contact.displayName ?? '',
        "phone": contact.phones?.isNotEmpty == true
            ? contact.phones!.first.value
            : '',
        "email":
            contact.emails?.map((e) => e.value).whereType<String>().toList() ??
            [],
        "mine_status": s.isSelected,
      };
    }).toList();
    debugPrint('Formatted Contacts: $formatted');
    CallResult<BaseEntity> response = await contactRepository.syncContacts(
      contacts: formatted,
    );

    if (response is Success<BaseEntity>) {
      emit(state.copyWith(status: ContactStatus.success));
    }
    if (response is Failure<BaseEntity>) {
      emit(
        state.copyWith(
          status: ContactStatus.error,
          errorMessage: response.cause,
        ),
      );
    }
  }
}
