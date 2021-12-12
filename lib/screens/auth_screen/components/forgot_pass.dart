import 'package:flutter/material.dart';

class ForgotPassBtn extends StatelessWidget {
  const ForgotPassBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 175, 1),
              fontSize: 15,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
