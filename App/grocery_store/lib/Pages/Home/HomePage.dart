import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MyWaveBackground(firstColor: Colors.blue[300]!, secondColor: Colors.blue[200]!,);
  }
}


class MyWaveBackground extends StatelessWidget {
  final Color firstColor;
  final Color secondColor;

  MyWaveBackground({required this.firstColor, required this.secondColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          color: firstColor,
        ),
        CustomPaint(
          painter: _WaveCustomPainter(backgroundColor: secondColor),
          size: Size(double.infinity, 300),
          // size: Size.infinite,
        ),
      ],
    );
  }
}

class _WaveCustomPainter extends CustomPainter {
  final Color backgroundColor;

  _WaveCustomPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    var path = Path();
    path.moveTo( size.width  / 2,  0);
    path.cubicTo(
      size.width / 2 , 1.3 * size.height / 4, 
      4 * size.width / 4, size.height / 4, 
      size.width  , size.height / 1.3
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width  / 2 , 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}