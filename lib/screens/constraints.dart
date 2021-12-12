import 'package:flutter/material.dart';

void hideKeyboard(
  BuildContext ctx,
) {
  FocusScope.of(ctx).requestFocus(FocusNode());
}

void showAuthMsg(BuildContext ctx, String msg) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));
}
