
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/screens/dashboard/contact_tab/contacts_tab_cubit.dart';
import '../../../../widget/progress.dart';
import '../../../../widget/state_view.dart';
import '../bloc/contacts_tab_state.dart';

class ContactsTabStateView extends StatelessWidget {
  final ContactsTabState state;

  const ContactsTabStateView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    var st = state;
    if (st is ContactsTabLoadingState) {
      return const ProgressView(
        isLoading: true,
        child: SizedBox(),
      );
    } else if (st is ContactsTabErrorState) {
      return StateView(
        title: "Something went wrong",
        message:"error message",
        action: "Try again",
        onAction: () {
          context.read<ContactsTabCubit>().fetchContactsData();
        },
      );
    }

    return StateView(
      title: "Contatcs",
      message: "No contacts found",
    );
  }
}
