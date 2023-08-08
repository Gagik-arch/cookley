import 'package:flutter/material.dart' as M;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cookley/resources/app_colors.dart';

enum VariantDropDown { primary, outlined, normal }

typedef VoidCallback = void Function();

// ignore: must_be_immutable
class DropDown<T> extends M.StatelessWidget {
  List<T> data;
  T? selected;
  String? hint;
  VariantDropDown variant;
  String? name;
  M.Widget? icon;
  bool isExpanded;
  String? label;
  void Function({T value, String? name}) onChange;
  M.Text Function(T state) showText;

  DropDown({
    M.Key? key,
    required this.data,
    required this.selected,
    required this.onChange,
    this.name,
    this.variant = VariantDropDown.outlined,
    this.hint,
    this.icon = const Icon(Icons.arrow_drop_down),
    required this.showText,
    this.isExpanded = false,
    this.label,
  }) : super(key: key);

  Map<VariantDropDown, M.Color> bgColor = {
    VariantDropDown.outlined: M.Colors.transparent,
    VariantDropDown.primary: const M.Color.fromRGBO(247, 250, 252, 1),
    VariantDropDown.normal: M.Colors.transparent
  };
  final Map<VariantDropDown, M.EdgeInsets> _padding = const {
    VariantDropDown.outlined: M.EdgeInsets.only(bottom: 10, top: 10),
    VariantDropDown.primary:
        M.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    VariantDropDown.normal: M.EdgeInsets.zero
  };
  Map<VariantDropDown, M.Border?> border = {
    VariantDropDown.outlined:
        M.Border(bottom: M.BorderSide(color: AppColor.lightGray, width: 1.0)),
    VariantDropDown.primary:
        M.Border.all(width: 0, color: M.Colors.transparent),
    VariantDropDown.normal: null
  };
  Map<VariantDropDown, M.BorderRadius?> borderRadius = {
    VariantDropDown.outlined: null,
    VariantDropDown.primary: const M.BorderRadius.all(M.Radius.circular(6)),
    VariantDropDown.normal: null,
  };

  @override
  M.Widget build(M.BuildContext context) {
    return M.Container(
      padding: _padding[variant],
      width: double.infinity,
      decoration: M.BoxDecoration(
        borderRadius: borderRadius[variant],
        color: bgColor[variant],
        border: border[variant],
      ),
      child: M.Column(
        crossAxisAlignment: M.CrossAxisAlignment.start,
        children: [
          if (label != null)
            M.Text(
              label.toString(),
              style: const M.TextStyle(
                  color: M.Color.fromRGBO(196, 196, 196, 1),
                  fontSize: 14,
                  fontWeight: M.FontWeight.w500),
            ),
          M.Row(
            children: [
              M.Flexible(
                child: M.DropdownButton<T>(
                  isDense: true,
                  isExpanded: isExpanded,
                  padding: M.EdgeInsets.zero,
                  value: selected,
                  hint: hint != null
                      ? M.Text(hint!,
                          style: M.TextStyle(color: AppColor.lightGray))
                      : null,
                  elevation: 16,
                  underline: M.Container(height: 0),
                  onChanged: (dynamic value) {
                    onChange(value: value, name: name);
                  },
                  icon: Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: icon,
                    ),
                  ),
                  items: data.map((T v) {
                    return M.DropdownMenuItem(
                      value: v,
                      child: showText(v),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
