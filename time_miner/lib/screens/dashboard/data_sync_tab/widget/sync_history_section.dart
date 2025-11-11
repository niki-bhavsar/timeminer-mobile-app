import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_miner/data/entity/sync_history_entity.dart';
import 'package:time_miner/screens/dashboard/data_sync_tab/state/sync_state.dart';
import 'package:time_miner/screens/dashboard/data_sync_tab/widget/sync_toggle_view.dart';
import 'package:time_miner/utils/intl_utils.dart';
import '../cubit/sync_data_cubit.dart';

class SyncHistorySection extends StatelessWidget {
  const SyncHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncDataCubit, DataSyncState>(
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.syncHistory.length,
                itemBuilder: (context, index) {
                  final item = state.syncHistory[index];
                  return _historyItem(context, item);
                },
              ),
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
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From Date: ${IntlUtil.getFullDate(item.startDate, dateFormat: "MMM-dd-yyyy")}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF16686A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'To Date: ${IntlUtil.getFullDate(item.endDate, dateFormat: "MMM-dd-yyyy")}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF16686A),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                item.status == 0 ? 'In Queue' : item.status ==1 ?  "Syncing" :   'Completed',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF16686A),
                ),
              ),
            ],
          ),
          const Divider(height: 16),
          SyncToggleView(
            label: 'Messages',
            value: item.syncMessages,
            onChanged: (val) => {},
          ),
          const SizedBox(height: 8),
          SyncToggleView(
            label: 'Call logs',
            value: item.syncCalls,
            onChanged: (val) => {},
          ),
        ],
      ),
    );
  }
}
