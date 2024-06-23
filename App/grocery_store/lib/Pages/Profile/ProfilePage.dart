import 'package:flutter/material.dart';
import 'package:grocery_store/Component/ThemeCustom.dart';
import 'package:grocery_store/Pages/Profile/Body.dart';
import 'package:grocery_store/Pages/Profile/Header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        backgroundColor: ThemeCustom.prof_backApp,
        // appBar: AppBar(
        //   backgroundColor: ThemeCustom.main_backgAppBar_v2,
        //   title: Text("Tài Khoản", style: TextStyle(fontFamily: "SanProBold", color: Colors.white),),
        // ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Header(),
            Expanded(
              child: 
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Body())
            ),
          
          ],
        ),
      ),
    );
  }

}