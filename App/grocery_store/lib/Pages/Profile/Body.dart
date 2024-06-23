import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String sell = "10tr";
  String buy = "30tr";
  String items = "100";

  @override
  Widget build(BuildContext context) {

    return Container(        
      height: double.infinity,    
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue[300]!,
            spreadRadius: 4,
            blurRadius: 10
          )
        ],
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(55), topRight: Radius.circular(55))
      ),
      child: Column( 
        mainAxisSize: MainAxisSize.min,     
        children: [
          _dashboard(sell: sell, buy: buy, items: items),
        ],
      ),
    );
  }

  _dashboard( { required sell, required buy, required items})
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      // color: Colors.red,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildContainer(
            color: Color.fromARGB(255, 49, 168, 244),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(sell , style: TextStyle(fontFamily: "SanProBold", color: Colors.white, fontSize: 18), textAlign: TextAlign.center,),
                      Text("Đã bán", style: TextStyle(fontFamily: "SanProBold", color: Colors.white70, fontSize: 13),),
                    ],
                  )
            ),

          _buildContainer(
            color: Color.fromARGB(255, 49, 168, 244),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(buy , style: TextStyle(fontFamily: "SanProBold", color: Colors.white, fontSize: 18), textAlign: TextAlign.center,),
                      Text("Đã nhập", style: TextStyle(fontFamily: "SanProBold", color: Colors.white70, fontSize: 13),),
                    ],
                  )
            ),
          _buildContainer(
            color: Color.fromARGB(255, 49, 168, 244),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(items , style: TextStyle(fontFamily: "SanProBold", color: Colors.white, fontSize: 18), textAlign: TextAlign.center,),
                      Text("Mặt hàng", style: TextStyle(fontFamily: "SanProBold", color: Colors.white70, fontSize: 13),),
                    ],
                  )
            ),
       
        ],
      ),
    );
  }
  _buildContainer({child, color})
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 85,
      height: 85,      
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),        
      ),
      child: child,
    );
  }
}