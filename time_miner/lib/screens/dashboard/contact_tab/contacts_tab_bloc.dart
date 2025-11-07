import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/entity/contacts_entity.dart';
import '../../../data/repository/contact_repository.dart';
import '../../../data/service/model/call_result.dart';
import 'bloc/contacts_tab_event.dart';
import 'bloc/contacts_tab_state.dart';

class ContactsTabBloc extends Bloc<ContactsTabEvent, ContactsTabState> {
  final ContactRepository contactRepository;

  // This has list of all hospital
  List<ContactItem> contactItems = [];


  ContactsTabBloc({
    required this.contactRepository,
  }) : super(ContactsTabInitialState()) {
    on<ContactsTabFetchEvent>(_handleContactsListFetchEvent);
    // on<ContactsTabSyncEvent>(_handleContactListSyncEvent);
  }

  _handleContactsListFetchEvent(
      ContactsTabFetchEvent event,
      Emitter<ContactsTabState> emit,
      ) async {
    emit(ContactsTabLoadingState());

    final result = await contactRepository.getContacts();
    print("REsult:::::$result");
    if (result is Failure<ContactsEntity>) {
      emit(ContactsTabErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<ContactsEntity>) {
      print(result.data.contactItems);
      contactItems = result.data.contactItems;
      emit(ContactsTabResultState());
    }
  }

  // _handleContactListSyncEvent(
  //     ContactsTabSyncEvent event,
  //     Emitter<FavouriteHospitalState> emit,
  //     ) async {
  //   emit(FavouriteHospitalLoadingState());
  //
  //   final result = await favouriteRepository.saveFavoriteHospital(hospitals: selectedHospitalList);
  //   if (result is Failure<BaseEntity>) {
  //     emit(FavouriteHospitalErrorState(
  //       error: result.cause,
  //       isAuthError: result.isAuthError(),
  //     ));
  //   } else if (result is Success<BaseEntity>) {
  //     emit(FavouriteHospitalSaveDataSuccessState(entity: result.data));
  //   }
  // }
}
