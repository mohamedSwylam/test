// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:test/core/routing/routes.dart';
import 'package:test/features/speech_recognation/ui/speech_screen.dart';


class AppRouter {
  MaterialPageRoute generateRoute(RouteSettings sittings) {
    switch (sittings.name) {
      case Routes.speechScreen:
        return MaterialPageRoute(
          builder: (_) =>  SpeechScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route definedfor ${sittings.name}'),
            ),
          ),
        );
    }
  }
}
