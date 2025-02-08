

import 'package:flutter/material.dart';

class TestSeatLayout extends StatefulWidget {
  final int rows;
  final int seatsPerRow;

  const TestSeatLayout({
    Key? key,
    this.rows = 10,
    this.seatsPerRow = 6,
  }) : super(key: key);

  @override
  State<TestSeatLayout> createState() => _TestSeatLayoutState();
}

class _TestSeatLayoutState extends State<TestSeatLayout> {late TransformationController _transformationController;
double _minScale = 0.4;

@override
void initState() {
  super.initState();
  _transformationController = TransformationController();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _fitToScreen();
  });
}

void _fitToScreen() {
  final Size screenSize = MediaQuery.of(context).size;
  final double containerWidth = widget.seatsPerRow * 40.0;
  final double containerHeight = widget.rows * 40.0;

  // Calculate scale to fit both width and height
  double scaleX = screenSize.width / containerWidth;
  double scaleY = screenSize.height / containerHeight;
  _minScale = scaleX < scaleY ? scaleX : scaleY;

  // Apply initial transformation to fit all seats
  final Matrix4 matrix = Matrix4.identity()
    ..scale(_minScale)
    ..translate(
      (screenSize.width / _minScale - containerWidth) / 2,
      (screenSize.height / _minScale - containerHeight) / 2,
    );

  _transformationController.value = matrix;
}

@override
void dispose() {
  _transformationController.dispose();
  super.dispose();
}

@override
Widget build(BuildContext context) {
  return InteractiveViewer(
    transformationController: _transformationController,
    minScale: _minScale * 0.5,
    maxScale: _minScale * 3.0,
    boundaryMargin: EdgeInsets.all(double.infinity),
    child: Center(
      child: CustomPaint(
        painter: SeatPainter(
          rows: widget.rows,
          seatsPerRow: widget.seatsPerRow,
        ),
        size: Size(widget.seatsPerRow * 40.0, widget.rows * 40.0),
      ),
    ),
  );
}
}

class SeatPainter extends CustomPainter {
  final int rows;
  final int seatsPerRow;

  SeatPainter({
    required this.rows,
    required this.seatsPerRow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final seatPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final seatWidth = 30.0;
    final seatHeight = 30.0;
    final spacing = 10.0;

    // Start drawing from left side
    for (int row = 0; row < rows; row++) {
      for (int seat = 0; seat < seatsPerRow; seat++) {
        final seatX = seat * (seatWidth + spacing);
        final seatY = row * (seatHeight + spacing);

        // Draw seat rectangle
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(seatX, seatY, seatWidth, seatHeight),
            Radius.circular(5.0),
          ),
          seatPaint,
        );

        // Add seat number
        final textPainter = TextPainter(
          text: TextSpan(
            text: '${row + 1}-${seat + 1}',
            style: TextStyle(fontSize: 10, color: Colors.black),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            seatX + (seatWidth - textPainter.width) / 2,
            seatY + (seatHeight - textPainter.height) / 2,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}