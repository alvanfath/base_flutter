import 'package:flutter/material.dart';
import 'package:flutter_cubit/app/constants/app_constants.dart';
import 'package:flutter_cubit/app/widgets/text.dart';

class ButtonWidget extends StatelessWidget {
  final double height;
  final Color color;
  final Color borderColor;
  final String text;
  final VoidCallback action;
  final bool isLoading;
  final Color? textColor;
  const ButtonWidget({
    super.key,
    required this.height,
    required this.color,
    required this.text,
    required this.action,
    required this.isLoading,
    required this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    const Widget isLoadingWidget = Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );

    final defaultWidget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextWidget(
        text: text,
        fontSize: 14,
        fontWeight: AppConstants.semiBold,
        color: textColor ?? Colors.white,
      ),
    );
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(color: borderColor, width: 1),
            ),
          ),
        ),
        onPressed: action,
        child: isLoading == true ? isLoadingWidget : defaultWidget,
      ),
    );
  }
}
