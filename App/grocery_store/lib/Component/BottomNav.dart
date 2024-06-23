import 'package:flutter/material.dart';
import 'package:grocery_store/Component/AppBarCustom.dart';
import 'package:grocery_store/Component/ThemeCustom.dart';
import 'package:grocery_store/Modules/CallChildrend.dart';

class BottomNav extends StatefulWidget {
  int index;
  PageController controller;
  CallChildrend callChild;
  GlobalKey<AppBarCustomState> appBarKey;
  BottomNav({
    required this.index,
    required this.controller,
    required this.callChild,
    required this.appBarKey,
    super.key});


  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    widget.callChild.updateIndex = UpdateIndex;
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.controller.dispose();
  }
  void onTab(int value)
  {
    setState(() {
      currentIndex = value;
    });
    if(value == 2)
    {
      // (widget.appBarKey.currentState as AppBarCustomState).updateTitle("Máy Tính");
    }
    widget.controller.jumpToPage(value);
  }

  void UpdateIndex(int index)
  {
    onTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: ThemeCustom.main_selectedIcon,
      
      type: BottomNavigationBarType.fixed,
      onTap: onTab,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.store), label: "Bán Hàng"),
        BottomNavigationBarItem(icon: Icon(Icons.warehouse), label: "Kho"),
        BottomNavigationBarItem(icon: Icon(null), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.public ), label: "Cộng Đồng"),
        BottomNavigationBarItem(icon: Icon(Icons.person ), label: "Tài Khoản"),
      ]
    );
  }
}