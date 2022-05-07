import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CardInfomationBaseSteps extends StatelessWidget {
  final Color startColorLinearGradient;
  final Color endColorLinearGradient;
  final String title;
  final Image image;
  final String parameter;
  final String parameterUnit;
  const CardInfomationBaseSteps({
    Key? key,
    required this.startColorLinearGradient,
    required this.endColorLinearGradient,
    required this.title,
    required this.image,
    required this.parameter,
    required this.parameterUnit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _borderRadius = 24;

    return Stack(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            gradient: LinearGradient(
              colors: [
                startColorLinearGradient,
                endColorLinearGradient,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          top: 0,
          child: CustomPaint(
            size: const Size(100, 150),
            painter: CustomCardShapePainter(
              _borderRadius,
              startColorLinearGradient,
              endColorLinearGradient,
            ),
          ),
        ),
        Positioned.fill(
          child: Row(
            children: <Widget>[
              Expanded(
                child: image,
                flex: 2,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Avenir',
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: parameter,
                            style: const TextStyle(
                              fontSize: 19,
                              color: Color.fromARGB(255, 39, 108, 165),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' $parameterUnit',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(
          size.width,
          size.height,
        ),
        [
          HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
          endColor
        ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
