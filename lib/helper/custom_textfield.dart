import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key, this.hinttext, this.onchanged});
  String? hinttext;
  TextEditingController controller = TextEditingController();
  Function(String)? onchanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        validator: (value) {
          if (value == null) return "value cant be null";
        },

        onChanged: onchanged,
        decoration: InputDecoration(
          hint: Text("$hinttext"),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.black, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.black, width: 1),
          ),
        ),
      ),
    );
  }
}
