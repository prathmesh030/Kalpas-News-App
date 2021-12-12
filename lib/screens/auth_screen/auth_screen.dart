import 'package:flutter/material.dart';
import '../auth_screen/components/body.dart';

class AuthScreen extends StatelessWidget {
  static String routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
