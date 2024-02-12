import 'package:flutter/material.dart';

class CheckBoxWidget extends StatelessWidget {
  final Widget content;
  final bool isActive;
  final Color color;
  const CheckBoxWidget({
    super.key,
    required this.content,
    required this.isActive,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        checkBox(isActive, color),
        const SizedBox(width: 10),
        Flexible(child: content),
      ],
    );
  }

  Widget checkBox(bool isSelected, Color checkColor) {
    if (isSelected == true) {
      return Container(
        width: 16,
        height: 16,
        decoration: ShapeDecoration(
          color: checkColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xffE9F6EB)),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 12,
        ),
      );
    } else {
      return Container(
        width: 16,
        height: 16,
        decoration: ShapeDecoration(
          color: const Color(0xFFF3F3F3),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFDDDDDD)),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
    }
  }
}
