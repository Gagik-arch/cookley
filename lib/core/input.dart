import 'package:flutter/material.dart';
import '../resources/app_colors.dart';
import '../resources/utils.dart';

class Validation {
  String errorMessage;
  RegExp validation;

  Validation(this.errorMessage, this.validation);
}

Map<String, Validation> regex = {
  //min 8 character, 1 number, 1 UPPERCASE, 1 lowercase, 1 special character
  'password': Validation(
    'Password must be at least 8 characters long, contains 1 UPPERCASE 1 lowercase 1 special charecter.',
    RegExp(
        '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@\$!%*?&])[A-Za-z\\d@\$!%*?&]{8,}\$'),
  ),
  'email': Validation(
      'Invalid email.',
      RegExp(
        "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])(?:[A-z])?\\.)+(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum|mail|ru)\\b",
      )),
  'phone': Validation('Invalid phone number.', RegExp('^[0-9\-\+]{9,15}\$')),
  'otp': Validation(
      'Needs minimum 6 charecters!', RegExp('^[A-Za-z\\d@\$!%*?&]{6,}\$')),
};

class Input extends StatefulWidget {
  Input({
    this.keyboardType = TextInputType.text,
    this.labelText,
    this.hintText,
    this.errorText,
    this.maxLines,
    this.name,
    this.onChange,
    this.onFinish,
    this.controller,
    this.value,
    this.label,
    this.autofocus = false,
    this.validationKey,
    this.errorMessage,
    this.maxLength,
    this.minLength,
    super.key,
  });

  TextInputType keyboardType;
  String? labelText;
  String? hintText;
  String? errorText;
  String? name;
  String? value;
  String? label;
  int? maxLines;
  bool autofocus;
  void Function({String value, String? name, bool? isValid})? onChange;
  void Function({String value, String? name, bool? isValid})? onFinish;
  TextEditingController? controller;
  String? validationKey;
  String? errorMessage;
  int? maxLength;
  int? minLength;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final _debouncer = Debouncer(milliseconds: 500);
  bool isValid = true;
  String? _defaultValue;

  @override
  void initState() {
    _defaultValue = widget.value;
    if (widget.validationKey != null && _defaultValue != null) {
      setState(() {
        isValid = _validateField(widget.validationKey, _defaultValue);
      });
    }

    super.initState();
  }

  bool _validateField(String? fieldName, String? text) {
    if (regex.containsKey(fieldName) && text != null) {
      print('9999999999999999 ${regex[fieldName]!.validation.hasMatch(text)}');
      return regex[fieldName]!.validation.hasMatch(text);
    }
    return false;
  }

  @override
  void dispose() {
    _debouncer.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  width: 1.5, color: Color.fromRGBO(196, 196, 196, 1)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label != null)
                Text(
                  widget.label!,
                  style: const TextStyle(
                    color: Color.fromRGBO(196, 196, 196, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              TextFormField(
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                autofocus: widget.autofocus,
                cursorColor: Colors.black,
                maxLines: widget.maxLines,
                initialValue: widget.value,
                maxLength: widget.maxLength,
                onChanged: (value) {
                  bool? _isValid_;

                  if (widget.validationKey != null) {
                    setState(() {
                      _isValid_ = _validateField(widget.validationKey, value);
                    });
                    isValid = _isValid_ ?? false;
                  }
                  if (widget.onChange != null) {
                    widget.onChange!(
                        value: value, name: widget.name, isValid: _isValid_);
                  }
                  if (widget.onFinish != null) {
                    _debouncer.run(() => widget.onFinish!(
                          value: value,
                          name: widget.name,
                          isValid: _isValid_,
                        ));
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  labelText: widget.labelText ?? '',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(width: 0, color: Colors.transparent),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(width: 0, color: Colors.transparent),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(width: 0, color: Colors.transparent),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(width: 0, color: Colors.transparent),
                  ),
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                      fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.5)),
                  labelStyle: TextStyle(fontSize: 16, color: AppColor.green),
                  errorText: widget.errorText,
                ),
              ),
            ],
          ),
        ),
        if (!isValid)
          Text(
            widget.errorMessage ??
                (regex.containsKey(widget.validationKey)
                    ? regex[widget.validationKey]!.errorMessage
                    : ''),
            style: const TextStyle(
              color: Color.fromRGBO(200, 60, 60, 0.85),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          )
      ],
    );
  }
}
