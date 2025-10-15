import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/sync_data_cubit.dart';

class SyncDataWidget extends StatelessWidget {
  const SyncDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SyncDataCubit, SyncDataState>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Push all available data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF16686A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Contacts', style: TextStyle(fontSize: 16)),
                        Switch(
                          value: state.contacts,
                          onChanged: (val) => context.read<SyncDataCubit>().toggleContacts(val),
                          activeColor: const Color(0xFF16686A),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Messages', style: TextStyle(fontSize: 16)),
                        Switch(
                          value: state.messages,
                          onChanged: (val) => context.read<SyncDataCubit>().toggleMessages(val),
                          activeColor: const Color(0xFF16686A),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Call logs', style: TextStyle(fontSize: 16)),
                        Switch(
                          value: state.callLogs,
                          onChanged: (val) => context.read<SyncDataCubit>().toggleCallLogs(val),
                          activeColor: const Color(0xFF16686A),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.syncing
                            ? null
                            : () => context.read<SyncDataCubit>().syncAll(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF16686A),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: state.syncing
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Sync Now',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Last sync: ${state.lastSync.isEmpty ? '-' : state.lastSync}',
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}