import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;

  const Logo({
    Key? key,
    required this.width,
    required this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/logo_starwars.svg',
      width: width,
      height: height,
      color: color,
    );
  }
}
