import 'package:flutter/material.dart';

class InputFormField extends StatefulWidget {
  final String hintText;
  final Function inputChangeVal;

  const InputFormField({
    Key? key,
    required this.hintText,
    required this.inputChangeVal,
  }) : super(key: key);

  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  bool isError = false;
  String errorMsg = '';

  customValidators(String inputName, String inputVal) {
    if (inputName == 'Email') {
      if (inputVal.isEmpty) {
        isError = true;
        errorMsg = 'Please fill out all fields!';
      } else if (!inputVal.contains("@")) {
        isError = true;
        errorMsg = 'Invalid email';
      }
    }

    // mobile

    if (inputName == 'Password') {
      if (inputVal.isEmpty) {
        isError = true;
        errorMsg = 'Please fill out all fields!';
      } else if (inputVal.length < 6) {
        isError = true;
        errorMsg = 'Password length must be 6 or more';
      }
    }

    if (inputName == 'Confirm Password') {
      if (inputVal.isEmpty) {
        isError = true;
        errorMsg = 'Please fill out all fields!';
      }
    }
    setState(() {});

    if (!isError) {
      return null;
    } else {
      return errorMsg;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 6,
      ),
      height: size.height * 0.05,
      padding: EdgeInsets.only(
        left: 20,
        bottom: 2,
      ),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
        border: isError
            ? Border.all(
                color: Colors.red,
              )
            : Border.all(
                color: Colors.transparent,
              ),
      ),
      child: TextFormField(
        // obscureText: true,

        validator: (val) {
          var ss = customValidators(widget.hintText, val.toString());
          // return ss;
          print(ss);
          if (isError) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(ss),
              duration: Duration(seconds: 2),
            ));
            return '';
          } else {
            return null;
          }
        },
        onChanged: (val) {
          setState(() {});
          isError = false;
          widget.inputChangeVal(val);
        },
        obscureText: (widget.hintText == "Password" ||
                widget.hintText == "Confirm Password")
            ? true
            : false,
        cursorColor: Colors.white,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          errorStyle: TextStyle(height: 0, color: Colors.transparent),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
