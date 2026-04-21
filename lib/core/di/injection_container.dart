// lib/core/di/injection_container.dart

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/word_local_datasource.dart';
import '../../data/repositories/word_repository_impl.dart';
import '../../domain/repositories/word_repository.dart';
import '../../domain/usecases/combine_words_usecase.dart';
import '../../domain/usecases/get_base_words_usecase.dart';
import '../../domain/usecases/get_canvas_words_usecase.dart';
import '../../domain/usecases/get_discovered_words_usecase.dart';
import '../../domain/usecases/save_canvas_words_usecase.dart';
import '../../domain/usecases/save_discovered_word_usecase.dart';
import '../../presentation/bloc/game_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<WordLocalDataSource>(() => WordLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<WordRepository>(() => WordRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetBaseWordsUseCase(sl()));
  sl.registerLazySingleton(() => CombineWordsUseCase(sl()));
  sl.registerLazySingleton(() => SaveDiscoveredWordUseCase(sl()));
  sl.registerLazySingleton(() => GetDiscoveredWordsUseCase(sl()));
  sl.registerLazySingleton(() => GetCanvasWordsUseCase(sl()));
  sl.registerLazySingleton(() => SaveCanvasWordsUseCase(sl()));

  sl.registerFactory(() => GameBloc(
      getBaseWordsUseCase: sl(),
      combineWordsUseCase: sl(),
      saveDiscoveredWordUseCase: sl(),
      getDiscoveredWordsUseCase: sl(),
      getCanvasWordsUseCase: sl(),
      saveCanvasWordsUseCase: sl(),
    ));
}