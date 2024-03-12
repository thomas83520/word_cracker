import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/semantics.dart';

class RotatingTriangle extends StatefulWidget {
  const RotatingTriangle({super.key});

  @override
  RotatingTriangleState createState() => RotatingTriangleState();
}

class RotatingTriangleState extends State<RotatingTriangle>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _rotationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _rotationController.forward();
        }
      });
    _rotationController.forward();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        final screenWidth = MediaQuery.of(context).size.width;
        final rotationAngle = lerpDouble(-20, 20, _rotationController.value)!;
        return Transform.rotate(
          alignment: Alignment.bottomCenter,
          angle: rotationAngle * pi / 180,
          child: CustomPaint(
            painter: TrianglePainter(),
            child: SizedBox(
              height: screenWidth,
              width: screenWidth,
            ),
          ),
        );
      },
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final point1 = Offset(size.width / 2, size.height);
    const point2 = Offset(0, 0);
    final point3 = Offset(size.width, 0);

    // Create a circular gradient fill
    final gradient = RadialGradient(
      colors: [
        Colors.white.withOpacity(0.5),
        Colors.grey[900]!
      ], // Customize the colors as desired
      stops: const [0.3, 0.8],
      focal: Alignment.bottomCenter,
      center: Alignment.center,
      focalRadius: -0.2,
    );

    // Add the triangle path
    path.moveTo(point1.dx, point1.dy);
    path.lineTo(point2.dx, point2.dy);
    path.lineTo(point3.dx, point3.dy);
    path.close();
    // Apply the circular gradient fill to the triangle
    final paint = Paint()..shader = gradient.createShader(path.getBounds());

    // Draw the triangle on the canvas
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;
}
