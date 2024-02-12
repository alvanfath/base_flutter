import 'package:flutter/material.dart';

class Divider extends StatelessWidget {
  final double height;
  final double marginVertical;
  final bool? isDashed;
  const Divider({
    super.key,
    required this.height,
    required this.marginVertical,
    this.isDashed = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isDashed == true) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashCount = (boxWidth / (2 * 5)).floor();
          return Flex(
            children: List.generate(dashCount, (index) {
              return Container(
                width: 5,
                height: 1,
                margin: EdgeInsets.symmetric(vertical: marginVertical),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              );
            }),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
          );
        },
      );
    }
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginVertical),
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: const BoxDecoration(
        color: Color(0xffEEEEEE),
      ),
    );
  }
}
