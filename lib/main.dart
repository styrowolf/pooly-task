import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pooly_task/screens/driver.dart';
import 'package:pooly_task/screens/rider_main.dart';
import 'package:pooly_task/screens/rider_signup.dart';
import 'package:pooly_task/screens/select_role.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(
    home: const SelectRoleScreen(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/rider': (BuildContext context) => const RiderMainScreen(),
      '/driver': (BuildContext context) => const DriverScreen(),
      '/riderSignup': (BuildContext context) => const RiderSignupScreen(),
    },
  )));
}