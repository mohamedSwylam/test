import 'package:flutter/material.dart';
import 'package:test/core/di/dependency_injection.dart';
import 'package:test/core/routing/app_router.dart';
import 'package:test/test_app.dart';

void main()  {
  setupLocator();
  runApp( TestApp(appRouter: AppRouter(),));
}
