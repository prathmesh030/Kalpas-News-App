import 'package:flutter/material.dart';

class RoundBtn extends StatelessWidget {
  final String btnText;
  final Function pressBtn;

  const RoundBtn({
    Key? key,
    required this.btnText,
    required this.pressBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.065,
      width: size.width * 0.35,
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            primary: Colors.lightBlueAccent,
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
          ),
          onPressed: () => pressBtn(),
          child: Text(
            btnText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
