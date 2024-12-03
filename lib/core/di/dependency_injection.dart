import 'package:get_it/get_it.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test/core/error/error_handler%20.dart';
import 'package:test/features/speech_recognation/logic/speech_cubit.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => SpeechToText());
  locator.registerLazySingleton(() => ErrorHandler());
  locator.registerFactory(() => SpeechCubit(locator<SpeechToText>(), locator<ErrorHandler>()));
}
