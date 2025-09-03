import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class FormCtrls {
  static Widget inputField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    IconData? icon,
    Color? backgroundColor,
    Color? textColor,
    bool useBorder = true,

    // ✅ New fields
    bool multiline = false,
    int minLines = 1,
    int maxLines = 1,
    VoidCallback? onSend, // send button callback
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: multiline ? TextInputType.multiline : keyboardType,
        obscureText: obscureText,
        style: TextStyle(color: textColor),
        minLines: multiline ? minLines : 1,
        maxLines: multiline ? maxLines : 1,
        decoration: InputDecoration(
          labelText: labelText,
          filled: backgroundColor != null,
          fillColor: backgroundColor,

          // ✅ FIX: Use InputBorder.none instead of null
          border: useBorder
              ? OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))
              : InputBorder.none, // ← This is the fix
          // ✅ Also set enabledBorder and focusedBorder for consistency
          enabledBorder: useBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                )
              : InputBorder.none,

          focusedBorder: useBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.blue.shade400),
                )
              : InputBorder.none,

          prefixIcon: icon != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Icon(icon, color: textColor),
                )
              : null,

          suffixIcon: onSend != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    color: textColor,
                    onPressed: onSend,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  static Widget dropdownField({
    required String labelText,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          filled: backgroundColor != null,
          fillColor: backgroundColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: TextStyle(color: textColor)),
          );
        }).toList(),
      ),
    );
  }

  static Widget datePickerField({
    required TextEditingController controller,
    required String labelText,
    required BuildContext context,
    String? Function(String?)? validator,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        readOnly: true,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          labelText: labelText,
          filled: backgroundColor != null,
          fillColor: backgroundColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          suffixIcon: Icon(Icons.calendar_today, color: textColor),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            controller.text = "${pickedDate.toLocal()}".split(' ')[0];
          }
        },
      ),
    );
  }

  static Widget radioButtonGroup({
    required String groupValue,
    required List<String> values,
    required ValueChanged<String?> onChanged,
    required String labelText,
    Color? activeColor,
    Color? textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: TextStyle(color: textColor)),
          Column(
            children: values.map((value) {
              return RadioListTile<String>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: activeColor,
                title: Text(value, style: TextStyle(color: textColor)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  static Widget checkboxGroup({
    required Map<String, bool> values,
    required ValueChanged<Map<String, bool>> onChanged,
    required String labelText,
    Color? activeColor,
    Color? textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: TextStyle(color: textColor)),
          Column(
            children: values.keys.map((key) {
              return CheckboxListTile(
                value: values[key],
                onChanged: (bool? newValue) {
                  values[key] = newValue!;
                  onChanged(values);
                },
                activeColor: activeColor,
                title: Text(key, style: TextStyle(color: textColor)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  static Widget fileUploadField({
    required String labelText,
    required ValueChanged<File?> onFileSelected,
    String? Function(File?)? validator,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: TextStyle(color: textColor)),
          ElevatedButton.icon(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                File file = File(result.files.single.path!);
                onFileSelected(file);
              } else {
                onFileSelected(null);
              }
            },
            icon: Icon(Icons.attach_file, color: textColor),
            label: Text('Choose File', style: TextStyle(color: textColor)),
            // style: ElevatedButton.styleFrom(
            //   primary: backgroundColor,
            // ),
          ),
        ],
      ),
    );
  }
}
