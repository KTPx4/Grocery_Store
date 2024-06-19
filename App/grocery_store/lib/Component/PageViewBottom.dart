import 'package:flutter/material.dart';
import 'package:grocery_store/Pages/Calculator/CalculatorPage.dart';
import 'package:grocery_store/Component/AppBarCustom.dart';
import 'package:grocery_store/Pages/Forum/ForumPage.dart';
import 'package:grocery_store/Pages/Home/HomePage.dart';
import 'package:grocery_store/Pages/Profile/ProfilePage.dart';
import 'package:grocery_store/Pages/Warehouse/WareHousePage.dart';

class PageViewCustom extends StatefulWidget {
  PageController controller;
  GlobalKey<AppBarCustomState> appBarKey;
  PageViewCustom({super.key, required this.controller, required this.appBarKey});

  @override
  State<PageViewCustom> createState() => _PageViewCustomState();
}

class _PageViewCustomState extends State<PageViewCustom> {

  Widget _buildPage(index)
  {
    switch(index)
    {
      case 1: 
        (widget.appBarKey.currentState as AppBarCustomState).updateTitle("Kho");
        return WareHousePage();
      case 2: 
       
        (widget.appBarKey.currentState as AppBarCustomState).updateTitle("Máy Tính");
        return CalculatorPage();
      case 3:
        (widget.appBarKey.currentState as AppBarCustomState).updateTitle("Cộng Đồng");
        return ForumPage();
      case 4:
        (widget.appBarKey.currentState as AppBarCustomState).updateTitle("Tài Khoản");
        return ProfilePage();

      default:
        (widget.appBarKey.currentState as AppBarCustomState).updateTitle("Bán Hàng");
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      controller: widget.controller,
      itemCount: 5,
      itemBuilder: (context, index) => _buildPage(index),
    );
  }
}