

import '../../../../data/entity/base_entity.dart';

sealed class ContactsTabState {}

class ContactsTabInitialState extends ContactsTabState {}

class ContactsTabLoadingState extends ContactsTabState {}

class ContactsTabResultState extends ContactsTabState {}

class ContactsTabSyncDataSuccessState extends ContactsTabState {
  final BaseEntity entity;

  ContactsTabSyncDataSuccessState({
    required this.entity,
  });
}

class ContactsTabErrorState extends ContactsTabState {
  final String error;
  final bool isAuthError;

  ContactsTabErrorState({
    required this.error,
    required this.isAuthError,
  });
}
