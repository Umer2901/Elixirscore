import 'package:flutter/material.dart';

class FitnessRings extends StatelessWidget {
  final double move;
  final double exercise;
  final double stand;

  FitnessRings({
    required this.move,
    required this.exercise,
    required this.stand,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: FitnessRingsPainter(move: move, exercise: exercise, stand: stand),
    );
  }
}

class FitnessRingsPainter extends CustomPainter {
  final double move;
  final double exercise;
  final double stand;

  FitnessRingsPainter({
    required this.move,
    required this.exercise,
    required this.stand,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double ringThickness = 15;
    double spacing = 8; // Spacing between rings

    // Define colors for each ring
    final moveColor = Colors.red;
    final exerciseColor = Colors.green;
    final standColor = Colors.blue;

    // Draw each ring with specified progress and spacing
    _drawRing(canvas, size, ringThickness, spacing * 2, standColor, stand);
    _drawRing(canvas, size, ringThickness, spacing * 4, exerciseColor, exercise);
    _drawRing(canvas, size, ringThickness, spacing * 6, moveColor, move);
  }

  void _drawRing(Canvas canvas, Size size, double thickness, double padding, Color color, double progress) {
    Paint backgroundPaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    Paint progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = thickness;

    double radius = (size.width / 2) - padding;
    Offset center = Offset(size.width / 2, size.height / 2);

    // Draw background ring
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    double sweepAngle = 2 * 3.141592653589793 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2, // Start angle (12 o'clock)
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
