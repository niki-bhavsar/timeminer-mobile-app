import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/sync_data_cubit.dart';
import 'widget/sync_data_widget.dart';

class SyncDataScreen extends StatelessWidget {
  const SyncDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SyncDataCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sync',
            style: TextStyle(
              color: Color(0xFF16686A),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          automaticallyImplyLeading: false,
        ),
        body: const SyncDataWidget(),
      ),
    );
  }
}