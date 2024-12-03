// ignore_for_file: file_names
import 'package:equatable/equatable.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechState extends Equatable {
  final bool isInitialized;
  final bool isListening;
  final String recognizedWords;
  final String error;
  final List<LocaleName> locales;
  final String currentLocale;

  const SpeechState({
    this.isInitialized = false,
    this.isListening = false,
    this.recognizedWords = '',
    this.error = '',
    this.locales = const [],
    this.currentLocale = '',
  });

  SpeechState copyWith({
    bool? isInitialized,
    bool? isListening,
    String? recognizedWords,
    String? error,
    List<LocaleName>? locales,
    String? currentLocale,
  }) {
    return SpeechState(
      isInitialized: isInitialized ?? this.isInitialized,
      isListening: isListening ?? this.isListening,
      recognizedWords: recognizedWords ?? this.recognizedWords,
      error: error ?? this.error,
      locales: locales ?? this.locales,
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }

  @override
  List<Object?> get props =>
      [isInitialized, isListening, recognizedWords, error, locales, currentLocale];
}
