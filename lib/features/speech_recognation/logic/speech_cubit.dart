import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:test/core/error/error_handler%20.dart';
import 'package:test/features/speech_recognation/logic/speech_state%20.dart';

class SpeechCubit extends Cubit<SpeechState> {
  final SpeechToText _speechToText;
  final ErrorHandler _errorHandler;

  SpeechCubit(this._speechToText, this._errorHandler)
      : super(const SpeechState());

  Future<void> initialize() async {
    try {
      bool hasSpeech = await _speechToText.initialize(
        onError: (error) => _handleError(error.errorMsg),
        onStatus: (status) => emit(state.copyWith(isListening: _speechToText.isListening)),
      );

      if (hasSpeech) {
        List<LocaleName> locales = await _speechToText.locales();
        LocaleName? systemLocale = await _speechToText.systemLocale();
        emit(state.copyWith(
          isInitialized: true,
          locales: locales,
          currentLocale: systemLocale?.localeId ?? '',
        ));
      } else {
        _handleError("Speech recognition not available.");
      }
    } catch (e) {
      _handleError(e.toString());
    }
  }

  void startListening(int listenDuration, int pauseDuration) {
    try {
      emit(state.copyWith(recognizedWords: '', error: ''));
      _speechToText.listen(
        onResult: _onResult,
        listenFor: Duration(seconds: listenDuration),
        pauseFor: Duration(seconds: pauseDuration),
        localeId: state.currentLocale,
      );
    } catch (e) {
      _handleError(e.toString());
    }
  }

  void stopListening() {
    _speechToText.stop();
    emit(state.copyWith(isListening: false));
  }

  void cancelListening() {
    _speechToText.cancel();
    emit(state.copyWith(isListening: false, recognizedWords: ''));
  }

  void _onResult(SpeechRecognitionResult result) {
    emit(state.copyWith(recognizedWords: result.recognizedWords));
  }

  void _handleError(String message) {
    _errorHandler.handleError(message);
    emit(state.copyWith(error: message));
  }

  void changeLocale(String? localeId) {
    emit(state.copyWith(currentLocale: localeId));
    return null;
  }
}
