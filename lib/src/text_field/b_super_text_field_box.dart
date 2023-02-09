import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class SuperTextFieldBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperTextFieldBox({
    @required this.child,
    @required this.width,
    @required this.height,
    @required this.margins,
    @required this.corners,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final double width;
  final double height;
  final dynamic margins;
  final dynamic corners;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

      return Container(
        key: const ValueKey<String>('SuperTextFieldBox'),
        width: width,
        margin: Scale.superMargins(margin: margins),
        decoration: BoxDecoration(
          borderRadius: Borderers.superCorners(context: context, corners: corners),
        ),
        alignment: Alignment.topCenter,
        child: child,
      );

  }
  /// --------------------------------------------------------------------------
}
