import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_miner/extension/build_context_extension.dart';
import 'package:time_miner/screens/dashboard/data_sync_tab/state/sync_state.dart';
import 'package:time_miner/screens/dashboard/data_sync_tab/widget/sync_history_section.dart';
import 'package:time_miner/screens/dashboard/data_sync_tab/widget/sync_toggle_view.dart';
import 'package:time_miner/widget/progress.dart';
import '../../../common/common_filled_button.dart';
import '../cubit/sync_data_cubit.dart';

class SyncDataWidget extends StatelessWidget {
  const SyncDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SyncDataCubit, DataSyncState>(
      listenWhen: (previous, current) =>
          previous.error != current.error && current.error != null,
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!), backgroundColor: Theme.of(context).colorScheme.error),
          );
        }
      },
      builder: (context, state) {
        return ProgressView(
          isLoading: state.isLoading ,
          child: Container(
            color: Theme.of(context).colorScheme.inverseSurface,//const Color(0xFFF5F5F5),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 0,
                top: 4,
                right: 0,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _pushDataSection(context, state),
                  const SizedBox(height: 8),
                  SyncHistorySection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _pushDataSection(BuildContext context, DataSyncState state) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Push all available data',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // Date pickers
          Row(
            children: [
              Expanded(
                child: _buildDatePicker(
                  context,
                  'Start Date',
                  state.startDate ??
                      DateTime(DateTime.now().year, DateTime.now().month, 1),
                  (date) => context.read<SyncDataCubit>().setStartDate(date),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDatePicker(
                  context,
                  'End date',
                  state.endDate ?? DateTime.now(),
                  (date) => context.read<SyncDataCubit>().setEndDate(date),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Toggle switches
          SyncToggleView(
            label: 'Messages',
            value: state.isMessageSyncEnable,
            onChanged: (val) =>
                context.read<SyncDataCubit>().toggleMessages(val),
          ),
          const SizedBox(height: 8),
          SyncToggleView(
            label: 'Call logs',
            value: state.isCallLogsSyncEnable,
            onChanged: (val) =>
                context.read<SyncDataCubit>().toggleCallLogs(val),
          ),
          const Divider(height: 24, color: Colors.white,),
          // Sync Now button
          SizedBox(
            width: double.infinity,
            child: CommonFilledButton(
              title: context.l10n.sync_now,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              textColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                context.hideKeyboard();
                if (!state.isSyncing) {
                  context.read<SyncDataCubit>().syncData();
                }
              },
            ),
          ),
          const SizedBox(height: 16),

          // Last sync info
          // Center(
          //   child: Text(
          //     context.l10n.last_sync + state.lastSync,
          //     style: const TextStyle(color: Colors.grey, fontSize: 15),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(
    BuildContext context,
    String label,
    DateTime initialDate,
    Function(DateTime) onDateChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:  TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              onDateChanged(date);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat('MM/dd/yyyy').format(initialDate),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Icon(
                  Icons.calendar_month,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
