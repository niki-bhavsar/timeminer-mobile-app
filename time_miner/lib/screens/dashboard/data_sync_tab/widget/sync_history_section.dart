import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/screens/dashboard/data_sync_tab/widget/sync_toggleView.dart';
import '../cubit/sync_data_cubit.dart';

class SyncHistorySection extends StatelessWidget {
  const SyncHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncDataCubit, SyncDataState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'History',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 16),

              // History items
              ...state.syncHistory.map((item) => _historyItem(context, item)),
            ],
          ),
        );
      },
    );
  }

  Widget _historyItem(BuildContext context, SyncHistoryItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sync Date: ${item.syncDate}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF16686A),
            ),
          ),
          const Divider(height: 16),
          SyncToggleView(
            label: 'Messages',
            value: item.messages,
            onChanged: (val) =>{}
                // context.read<SyncDataCubit>().toggleMessages(val),
          ),
          const SizedBox(height: 8),
          SyncToggleView(
            label: 'Call logs',
            value: item.callLogs,
            onChanged: (val) =>{}
                // context.read<SyncDataCubit>().toggleCallLogs(val),
          ),
        ],
      ),
    );
  }
}
