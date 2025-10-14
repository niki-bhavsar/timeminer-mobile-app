
import 'package:contacts_service/contacts_service.dart';

class ContactSelection {
  final Contact contact;
  bool isSelected;

  ContactSelection({required this.contact, this.isSelected = false});
}