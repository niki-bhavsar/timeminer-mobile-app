

import 'package:equatable/equatable.dart';
import 'package:time_miner/screens/contacts/model/contact_selection_model.dart';

enum ContactStatus { initial, loading, loaded, permissionDenied, syncing, error, success }

class ContactState extends Equatable {
  final ContactStatus status;
  final List<ContactSelection> contacts;
  final List<ContactSelection> filteredContacts;
  final String searchQuery;
  final String? errorMessage;

  const ContactState({
    this.status = ContactStatus.initial,
    this.contacts = const [],
    this.filteredContacts = const [],
    this.searchQuery = '',
    this.errorMessage,
  });


  ContactState copyWith({
    ContactStatus? status,
    List<ContactSelection>? contacts,
    List<ContactSelection>? filteredContacts,
    String? searchQuery,
    String? errorMessage,
  }) {
    return ContactState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
      filteredContacts: filteredContacts ?? this.filteredContacts,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, contacts, filteredContacts, searchQuery, errorMessage];
}
