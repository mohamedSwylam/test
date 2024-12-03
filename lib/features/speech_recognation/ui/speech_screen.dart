import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/core/di/dependency_injection.dart';
import 'package:test/core/helper/spacing.dart';
import 'package:test/core/theming/colors.dart';
import 'package:test/core/theming/style.dart';
import 'package:test/features/speech_recognation/logic/speech_state%20.dart';
import '../logic/speech_cubit.dart';

class SpeechScreen extends StatelessWidget {
  final TextEditingController _listenForController =
      TextEditingController(text: '30');
  final TextEditingController _pauseForController =
      TextEditingController(text: '3');

  SpeechScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<SpeechCubit>()..initialize(),
      child: Scaffold(
        //appBar: AppBar(title: const Text('Speech to Text')),
        body: BlocBuilder<SpeechCubit, SpeechState>(
          builder: (context, state) {
            final cubit = context.read<SpeechCubit>();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!state.isInitialized)
                    const Center(child: CircularProgressIndicator())
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "We're excited to have you back, kindly choose your speech language .",
                          style: TextStyles.font15DarkBlueMedium,
                        ),
                        verticalSpace(20),
                        DecoratedBox(
                          decoration: BoxDecoration(
                              color: ColorsManger.mainLightGreen,
                              //background color of dropdown button
                              border: Border.all(
                                  color: Colors.black38,
                                  width: 2), //border of dropdown button
                              borderRadius: BorderRadius.circular(
                                  30), //border raiuds of dropdown button
                              boxShadow: const <BoxShadow>[
                                //apply shadow on Dropdown button
                                BoxShadow(
                                    color: Color.fromRGBO(
                                        0, 0, 0, 0.57), //shadow for button
                                    blurRadius: 5) //blur radius of shadow
                              ]),
                          child: DropdownButton<String>(
                            alignment: Alignment.center,
                            isExpanded: true,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            value: state.currentLocale,
                            onChanged: cubit.changeLocale,
                            items: state.locales
                                .map((locale) => DropdownMenuItem(
                                      value: locale.localeId,
                                      child: Text(locale.name),
                                    ))
                                .toList(),
                          ),
                        ),
                        verticalSpace(30),
                        Text(
                          "Recognized Word ",
                          style: TextStyles.font15DarkBlueMedium,
                        ),
                        verticalSpace(30),
                        Container(
                          width: double.infinity,
                          height: 300.h,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: ColorsManger.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(4, 4),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            state.recognizedWords,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        verticalSpace(80),
                        Center(
                          child: AvatarGlow(
                            animate: state.isListening,
                            glowColor: Theme.of(context).primaryColor,
                            duration: const Duration(milliseconds: 2000),
                            repeat: true,
                            child: FloatingActionButton(
                              backgroundColor: ColorsManger.mainLightGreen,
                              onPressed: state.isListening
                                  ? cubit.stopListening
                                  : () => cubit.startListening(
                                        int.parse(_listenForController.text),
                                        int.parse(_pauseForController.text),
                                      ),
                              child: Icon(
                                state.isListening ? Icons.mic : Icons.mic_none,
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(20),
                        if (state.error.isNotEmpty)
                          Center(
                            child: Text(
                              state.error,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
