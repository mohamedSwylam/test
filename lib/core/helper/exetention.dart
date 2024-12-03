import 'package:flutter/widgets.dart';

extension NavigationExtension on BuildContext {
  
  // Navigate to a new page (push)
  Future<dynamic> pushNamed(String routeName,{Object? arguments}) {
    return Navigator.of(this).pushNamed(
      routeName,arguments:arguments);
  }

  // Replace current page with a new one (pushReplacement)
   Future<dynamic> pushReplacementNamed(String routeName,{Object? arguments}) {
    return Navigator.of(this).pushReplacementNamed(
      routeName,arguments:arguments);
  }

  // Navigate back (pop)
  void pop() {
    Navigator.of(this).pop();
  }

  // Push and remove all previous routes (pushAndRemoveUntil)
  Future<dynamic> pushNamedAndRemoveUntil(String routeName,{Object? arguments,required RoutePredicate predicate}) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,predicate,arguments:arguments);
  }
}
