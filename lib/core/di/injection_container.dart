// lib/core/di/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/word_local_datasource.dart';
import '../../data/repositories/word_repository_impl.dart';
import '../../domain/repositories/word_repository.dart';
import '../../domain/usecases/combine_words_usecase.dart';
import '../../domain/usecases/get_base_words_usecase.dart';
import '../../domain/usecases/save_discovered_word_usecase.dart';
import '../../presentation/bloc/game_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ── External ─────────────────────────────
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // ── Data Sources ──────────────────────────
  sl.registerLazySingleton<WordLocalDataSource>(
    () => WordLocalDataSourceImpl(sl()),
  );

  // ── Repositories ──────────────────────────
  sl.registerLazySingleton<WordRepository>(
    () => WordRepositoryImpl(sl()),
  );

  // ── Use Cases ─────────────────────────────
  sl.registerLazySingleton(() => GetBaseWordsUseCase(sl()));
  sl.registerLazySingleton(() => CombineWordsUseCase(sl()));
  sl.registerLazySingleton(() => SaveDiscoveredWordUseCase(sl()));

  // ── BLoC ──────────────────────────────────
  sl.registerFactory(
    () => GameBloc(
      getBaseWordsUseCase: sl(),
      combineWordsUseCase: sl(),
      saveDiscoveredWordUseCase: sl(),
    ),
  );
}
