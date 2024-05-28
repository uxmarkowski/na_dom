import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:na_dom/design.dart';


class CustomDateTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hingText;
  final bool obscureText;
  const CustomDateTextField({
    super.key,
    required this.controller,
    required this.hingText,
    required this.obscureText,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: TextInputType.number,
        inputFormatters: [
          DateTextFormatter(),
        ],
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
}


class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String separator = '.';
    var text = _format(
      newValue.text,
      oldValue.text,
      separator,
    );

    return newValue.copyWith(
      text: text,
      selection: updateCursorPosition(
        oldValue,
        text,
      ),
    );
  }

  String _format(
      String value,
      String oldValue,
      String separator,
      ) {
    var isErasing = value.length < oldValue.length;
    var isComplete = value.length > _maxChars + 2;

    if (!isErasing && isComplete) {
      return oldValue;
    }

    value = value.replaceAll(separator, '');
    final result = <String>[];

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      result.add(value[i]);
      if ((i == 1 || i == 3) && i != value.length - 1) {
        result.add(separator);
      }
    }

    return result.join();
  }

  TextSelection updateCursorPosition(
      TextEditingValue oldValue,
      String text,
      ) {
    var endOffset = max(
      oldValue.text.length - oldValue.selection.end,
      0,
    );

    var selectionEnd = text.length - endOffset;

    return TextSelection.fromPosition(TextPosition(offset: selectionEnd));
  }
}

