import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/dashboard/account_tab/account_block.dart';
import 'package:time_miner/screens/dashboard/account_tab/state/account_event.dart';
import 'package:time_miner/widget/app_dialog.dart';

import '../../../../theme/assets.dart';

class AccountTabView extends StatelessWidget {
  const AccountTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionPref = GetIt.instance.get<SessionPref>();

    return Column(
      children: [
        _buildHeader(context, sessionPref),
        const SizedBox(height: 24),
        _buildPermissionSwitch(context),
        const Spacer(),
        _buildLogoutButton(context),
        const SizedBox(height: 16),
        Text(
          'Version V 1.1',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, SessionPref sessionPref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.accountBG),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                width: 4.0,
              ),
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              backgroundImage:
                  NetworkImage(sessionPref.getUserProfile()!) as ImageProvider,
              // (sessionPref.getAuthToken().isNotEmpty)
              //     ? NetworkImage(sessionPref.getUserProfile()!) as ImageProvider
              //     : const AssetImage('assets/images/profile1.png'),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            sessionPref.getSignUpUserName(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sessionPref.getSignUpEmail(),
            style:  TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 13
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionSwitch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Dialer/messenger permissions',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Switch(
            value: true,
            onChanged: (val) {},
            activeTrackColor: Theme.of(
              context,
            ).colorScheme.onSecondaryContainer,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.white24,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          AppDialog(
            title: context.l10n.settingsScreen_general_logout,
            message: context.l10n.settingsScreen_logoutDialog_message,
            positiveText: context.l10n.action_yes,
            negativeText: context.l10n.action_cancel,
            onPositiveClick: () {
              context.read<AccountBlock>().add(SettingLogoutClickEvent());
            },
          ).show(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer,      // <-- your border color here
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text('Logout', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
