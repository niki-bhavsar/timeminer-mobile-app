import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_miner/screens/dashboard/data_sync_tab/widget/sync_history_section.dart';
import 'package:time_miner/screens/dashboard/data_sync_tab/widget/sync_toggleView.dart';
import '../cubit/sync_data_cubit.dart';

class SyncDataWidget extends StatelessWidget {
  const SyncDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncDataCubit, SyncDataState>(
      builder: (context, state) {
        return Container(
          color: const Color(0xFFF5F5F5),
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
        );
      },
    );
  }

  Widget _pushDataSection(BuildContext context, SyncDataState state) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Push all available data',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: const Color(0xFF16686A),
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
                  state.startDate ?? DateTime(2025, 1, 1),
                  (date) => context.read<SyncDataCubit>().setStartDate(date),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDatePicker(
                  context,
                  'End date',
                  state.endDate ?? DateTime(2025, 5, 5),
                  (date) => context.read<SyncDataCubit>().setEndDate(date),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Toggle switches
          SyncToggleView(
            label: 'Messages',
            value: state.messages,
            onChanged: (val) =>
                context.read<SyncDataCubit>().toggleMessages(val),
          ),
          const SizedBox(height: 8),
          SyncToggleView(
            label: 'Call logs',
            value: state.callLogs,
            onChanged: (val) =>
                context.read<SyncDataCubit>().toggleCallLogs(val),
          ),
          const Divider(height: 24),
          // Sync Now button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.syncing
                  ? null
                  : () => context.read<SyncDataCubit>().syncAll(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16686A),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: state.syncing
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Sync Now',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),

          // Last sync info
          Center(
            child: Text(
              'Last sync: ${state.lastSync}',
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
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
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat('MM/dd/yyyy').format(initialDate),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Icon(
                  Icons.calendar_month,
                  size: 20,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
