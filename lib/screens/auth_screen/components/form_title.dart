import 'package:flutter/material.dart';

class AuthFormTitle extends StatelessWidget {
  final String title;

  const AuthFormTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        bottom: size.height * 0.02,
        top: size.height * 0.02,
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 139, 1),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      width: size.width,
      // color: Colors.red,
    );
  }
}
