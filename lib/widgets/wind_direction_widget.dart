import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

class WindDirectionWidget extends StatelessWidget {
  final double windDegree;
  final bool isDaytime;

  const WindDirectionWidget({
    Key? key,
    required this.windDegree,
    required this.isDaytime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Adjust rotation if your arrow points "up"
    final angleInRadians = (windDegree) * pi / 180;

    final textColor = isDaytime ? Colors.white : Colors.black;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.rotate(
          angle: angleInRadians,
          child: SvgPicture.asset(
            'assets/arrow.svg',
            width: 50,
            height: 50,
            colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _getDirectionLabel(windDegree),
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  String _getDirectionLabel(double degree) {
    if (degree >= 337.5 || degree < 22.5) return "N";
    if (degree >= 22.5 && degree < 67.5) return "NE";
    if (degree >= 67.5 && degree < 112.5) return "E";
    if (degree >= 112.5 && degree < 157.5) return "SE";
    if (degree >= 157.5 && degree < 202.5) return "S";
    if (degree >= 202.5 && degree < 247.5) return "SW";
    if (degree >= 247.5 && degree < 292.5) return "W";
    return "NW";
  }
}
