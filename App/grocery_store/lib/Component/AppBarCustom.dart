import 'package:flutter/material.dart';
import 'package:grocery_store/Component/ThemeCustom.dart';

class AppBarCustom extends StatefulWidget implements PreferredSizeWidget{
  final GlobalKey<State<AppBarCustom>> key;

  const AppBarCustom({ required this.key}) : super(key: key);

  @override
  State<AppBarCustom> createState() => AppBarCustomState();
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight ); 


}

class AppBarCustomState extends State<AppBarCustom> with SingleTickerProviderStateMixin{
  String _title = "";
  List<Widget> _action = [];

  Color? _titleColor;
  Color? _background;

  @override
  Widget build(BuildContext context) {

    _titleColor = ThemeCustom.main_titleAppBar;
    _background = ThemeCustom.main_backgAppBar;

    return AppBar(
      backgroundColor: _background,
      title:  Text(_title, style: TextStyle(color: _titleColor, fontFamily: "SanProBold",),),
      actions: _action,
    );
  }

  void updateTitle(String title)
  {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted)
      {
        setState(() {
          _title = title;
        });
      }
    });
  }

  void updateAction(List<Widget> action)
  {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted)
      {
        setState(() {
          _action = action;
        });
      }
    });
  }
  
  void clear()
  {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted)
      {
        setState(() {
          _title = "";
          _action = [];
        });
      }
    });
  }
}