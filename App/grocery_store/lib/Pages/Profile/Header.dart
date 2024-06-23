import 'package:flutter/material.dart';
import 'package:grocery_store/Component/ThemeCustom.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  @override
  Widget build(BuildContext context) {
    return 
        MyWaveBackground(firstColor: ThemeCustom.prof_backApp, secondColor: Color.fromARGB(239, 100, 180, 246)!,);        
   
  }
}


class MyWaveBackground extends StatefulWidget {
  final Color firstColor;
  final Color secondColor;

  MyWaveBackground({required this.firstColor, required this.secondColor});

  @override
  State<MyWaveBackground> createState() => _MyWaveBackgroundState();
}

class _MyWaveBackgroundState extends State<MyWaveBackground> {
  String name = "Kiều Thành Phát";

  String email = "px4.vnd@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 160,
          color: widget.firstColor,
        ),
        CustomPaint(
          painter: _WaveCustomPainter(backgroundColor: widget.secondColor),
          size: Size(double.infinity, 170),
          // size: Size.infinite,
        ),
        Container(
          margin: EdgeInsets.only(top: 79),
          child: Center(          
            child: Column(
               children: [
                 Text(name , 
                  style: const TextStyle(fontFamily: "SanProBold", fontSize: 18, color: Colors.black),),
            
                  Text(email , 
                    style:  TextStyle(fontFamily: "SanPro", fontSize: 14,   color: Colors.black54), overflow: TextOverflow.ellipsis,),
                  const SizedBox(height: 10,),
               ],
            ),
          ),
        )
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
    path.moveTo( size.width  / 2.6,  0);
    path.cubicTo(
      size.width / 2 , 1.3 * size.height / 4, 
      4 * size.width / 4, size.height / 4, 
      size.width  , size.height / 1
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width  / 2 , 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}