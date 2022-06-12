import 'package:flutter/material.dart';
import 'package:weathertastic/widgets/card_layout.dart';
class ReusableCard extends StatelessWidget {
  late final Widget childWidget;

  ReusableCard({required this.childWidget});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0xff99C4C8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: childWidget,
      ),
    );
  }
}
