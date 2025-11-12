import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_miner/data/repository/sync_data_repository.dart';
import 'package:time_miner/data/service/sync_data_service.dart';
import 'package:time_miner/data/shared_pref/session_pref.dart';
import 'package:time_miner/data/shared_pref/session_pref_impl.dart';

Future registerGetItModules() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.reload();

  var getIt = GetIt.instance;
  getIt.registerLazySingleton<SessionPref>(() => SessionPrefImpl(prefs));

  getIt.registerLazySingleton<SyncDataService>(() => SyncDataService());

  // 🧩 SyncDataRepository setup
  getIt.registerLazySingleton<SyncDataRepository>(
    () => SyncDataRepositoryImpl(
      syncDataService: getIt<SyncDataService>(),
      sessionPref: getIt<SessionPref>(),
    ),
  );
}
