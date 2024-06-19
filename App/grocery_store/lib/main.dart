import 'package:flutter/material.dart';
import 'package:grocery_store/Component/AppBarCustom.dart';
import 'package:grocery_store/Component/BottomNav.dart';
import 'package:grocery_store/Component/PageViewBottom.dart';
import 'package:grocery_store/Component/ThemeCustom.dart';
import 'package:grocery_store/Modules/CallChildrend.dart';

void main()
{
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppHome(),
    )
  );
}

class AppHome extends StatefulWidget {
  AppHome({super.key});
  final GlobalKey<AppBarCustomState> appBarKey = GlobalKey<AppBarCustomState>();
  int currentIndex = 0;
  late PageController _controller;
  CallChildrend callChild = CallChildrend();

  @override
  State<AppHome> createState() => _AppHomeState();
  
}

class _AppHomeState extends State<AppHome> {
  @override
  void initState() {
    widget._controller = PageController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBarCustom(key: widget.appBarKey),
      bottomNavigationBar: BottomNav(index: widget.currentIndex, controller: widget._controller,callChild: widget.callChild, appBarKey:  widget.appBarKey,),
      body: PageViewCustom(controller: widget._controller, appBarKey: widget.appBarKey),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        shape: CircleBorder(),
        backgroundColor: ThemeCustom.main_iconCalculator,
         child: IconButton(
          onPressed: (){
            widget.callChild.updateIndex(2);
          }, 
          icon: Icon(Icons.calculate, color: Colors.white,)
        ),     

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}