import 'package:artapp/widgets/getOfContextDatas.dart';
import 'package:flutter/material.dart';

TextFormField appTextFormField(
    {@required TextEditingController? controller,
    Function(String)? onChanged,
    @required String? name,
    bool obscureText = false}) {
  return TextFormField(
    controller: controller,
    onChanged: onChanged,
    obscureText: obscureText,
    decoration: InputDecoration(
        border: InputBorder.none,
        labelText: name,
        labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
  );
}
