import 'package:flutter/material.dart';
import 'package:na_dom/design.dart';

Widget CustomTextField ({
  required controller,
  required hingText,
  required obscureText,
  required focusNode,
  required onTextEditionComplete,
  keyBoartIsNumbers
}) {

  return Container(
    height: 44,
    width: double.infinity,
    child: TextField(
      onEditingComplete: () {
        onTextEditionComplete;
      },

      controller:  controller,
      focusNode:   focusNode,
      obscureText: obscureText,
      keyboardType: keyBoartIsNumbers == true ? TextInputType. number : null,
      style: TextStyle(color: Color.fromRGBO(102, 112, 133, 1), fontSize: 14, fontWeight: FontWeight.normal),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorBorderTextField),
              borderRadius: BorderRadius.circular(8)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorBorderTextField),
              borderRadius: BorderRadius.circular(8)

          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hingText,
          hintStyle: TextStyle(color: colorHintText, fontSize: 14, fontWeight: FontWeight.normal)
      ),
    ),
  );
}


Widget CustomTextFieldWithoutFuncions ({
  required controller,
  required hingText,
  required obscureText,
  required focusNode,

  keyBoartIsNumbers
}) {

  return Container(
    height: 44,
    width: double.infinity,
    child: TextField(


      controller:  controller,
      focusNode:   focusNode,
      obscureText: obscureText,
      keyboardType: keyBoartIsNumbers == true ? TextInputType. number : null,
      style: TextStyle(color: Color.fromRGBO(102, 112, 133, 1), fontSize: 14, fontWeight: FontWeight.normal),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorBorderTextField),
              borderRadius: BorderRadius.circular(8)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorBorderTextField),
              borderRadius: BorderRadius.circular(8)

          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hingText,
          hintStyle: TextStyle(color: colorHintText, fontSize: 14, fontWeight: FontWeight.normal)
      ),
    ),
  );
}





class PasswordCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hingText;
  final Function changeObscuredText;
  final bool obscureText;
  const PasswordCustomTextField({
    super.key,
    required this.controller,
    required this.hingText,
    required this.changeObscuredText,
    required this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hingText,
          hintStyle: const TextStyle(color: Colors.grey),

          suffixIcon: IconButton(
            padding: EdgeInsets.only(right: 12),
            icon: obscureText ? Icon(Icons.visibility_off_outlined) : Icon(Icons.visibility_outlined),
            onPressed: () {
              changeObscuredText();
            },
          )

      ),
    );
  }
}

