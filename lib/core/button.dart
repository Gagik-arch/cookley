import 'package:flutter/material.dart';

import '../resources/main.dart';

enum Variant { primary, secondary, outlined, normal }

class Button extends StatelessWidget {
  Button({
    super.key,
    this.child,
    required this.onPress,
    this.variant = Variant.normal,
    this.label,
    this.alignment,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.textStyle,
    this.border,
    this.width,
    this.disabled = false,
    this.onDisabled,
    this.onLongPress,
  });

  final Widget? child;
  final String? label;
  final void Function() onPress;
  final void Function()? onDisabled;
  final void Function()? onLongPress;
  final Variant variant;
  final Alignment? alignment;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Border? border;
  final double? width;
  bool disabled;

  final Map<Variant, Color> _bgColor = {
    Variant.normal: Colors.transparent,
    Variant.primary: AppColor.green,
    Variant.secondary: AppColor.lightGray,
    Variant.outlined: Colors.transparent,
  };

  final Map<Variant, Color> _textColor = {
    Variant.normal: Colors.black,
    Variant.primary: Colors.white,
    Variant.secondary: Colors.black.withOpacity(0.55),
    Variant.outlined: AppColor.green,
  };

  final Map<Variant, Border> _border = {
    Variant.normal: const Border(),
    Variant.primary: Border.all(width: 1, color: AppColor.green),
    Variant.secondary: Border.all(width: 1, color: AppColor.lightGray),
    Variant.outlined: Border(
      bottom: BorderSide(color: AppColor.lightGray, width: 1.0),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: (TapDownDetails _) {
        if (onLongPress != null) {
          onLongPress!();
        }
      },
      onTap: () {
        if (disabled) {
          if (onDisabled != null) {
            onDisabled!();
          }
        } else {
          onPress();
        }
      },
      child: Container(
        width: width,
        alignment:
            alignment ?? (variant == Variant.normal ? null : Alignment.center),
        padding: padding ??
            ((variant == Variant.normal)
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(vertical: 10, horizontal: 16)),
        decoration: BoxDecoration(
          border: !disabled
              ? (border ?? _border[variant])
              : Border.all(width: 1, color: Colors.red.shade200),
          color: !disabled
              ? (backgroundColor ?? _bgColor[variant])
              : Colors.red.shade200,
          borderRadius: borderRadius ??
              (variant == Variant.outlined || variant == Variant.normal
                  ? null
                  : BorderRadius.circular(16)),
        ),
        child: child ??
            Text(
              label!,
              style: textStyle ??
                  TextStyle(
                    color: _textColor[variant],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
      ),
    );
  }
}
