import 'package:flutter/material.dart';
import 'package:grocery_store/Component/ThemeCustom.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String sell = "10tr";
  String buy = "30tr";
  String items = "100";
  bool autoSync = true;

  changeName()
  {

  }

  changeEmail()
  {

  }

  changePass()
  {

  }

  changeSync()
  {
    setState(() {
      autoSync = !autoSync;
    });
  }

  logOut() async
  {
    var rs = await showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: ThemeCustom.prof_backApp,
          title: Text("Đăng xuất", style: TextStyle(fontFamily: "SanProBold"),),
          content: Text("Bạn muốn đăng xuất?", style: TextStyle(fontFamily: "SanPro",fontSize: 16)),
          actions: [
            TextButton( 
              onPressed: () {
                Navigator.pop(context, true);
              }, 
              child: Text("Có", style: TextStyle(fontFamily: "SanProBold", color: Colors.red)),
            ),
            TextButton( 
              onPressed: () {
                Navigator.pop(context, false);
              }, 
              child: Text("Không", style: TextStyle(fontFamily: "SanProBold", color: Colors.blue[400])),
            ),
          ],
        );
      },
    );
    print(rs);
  }


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
        color: ThemeCustom.prof_backApp_v2,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(55), topRight: Radius.circular(55))
      ),
      child: Column( 
        mainAxisSize: MainAxisSize.min,     
        children: [
          _dashboard(sell: sell, buy: buy, items: items),
          _setting()
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
          _buttonDashB(
            color: Color.fromARGB(255, 49, 168, 244),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(sell , style: TextStyle(fontFamily: "SanProBold", color: Colors.white, fontSize: 18), textAlign: TextAlign.center,),
                      Text("Đã bán", style: TextStyle(fontFamily: "SanProBold", color: Colors.white70, fontSize: 13),),
                    ],
                  )
            ),

          _buttonDashB(
            color: Color.fromARGB(255, 49, 168, 244),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(buy , style: TextStyle(fontFamily: "SanProBold", color: Colors.white, fontSize: 18), textAlign: TextAlign.center,),
                      Text("Đã nhập", style: TextStyle(fontFamily: "SanProBold", color: Colors.white70, fontSize: 13),),
                    ],
                  )
            ),
          _buttonDashB(
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
  _buttonDashB({child, color, ontap})
  {
    return Material(     
      color: Colors.transparent, 
      child: InkWell(        
        onTap: ontap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 85,
          height: 85,      
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),        
            boxShadow: [
              BoxShadow(
                color: Colors.blue[300]!,
                spreadRadius: 1,                
                blurRadius: 9,
                offset: Offset(1, 1)
              )
            ]
          ),
          child: child,
        ),
      ),
    );
  }

  _setting()
  {
    var list = [
      {"title" : "Đổi tên", "icon": Icons.person, "function": changeName},
      {"title" : "Đổi email",  "icon": Icons.email, "function": changeEmail},
      {"title" : "Đổi mật khẩu",  "icon": Icons.password_rounded, "function": changePass},
      {"title" : "Đồng bộ dữ liệu",  "icon": Icons.sync, "function": changeSync},
      {"title" : "Đăng xuất",  "icon": Icons.logout, "function": logOut},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeCustom.prof_backApp_v2,
        border: Border.all(
          width: 1,
          color: Colors.grey[300]!
        ),
        borderRadius: BorderRadius.circular(8)
      ),      

      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(list[index]["title"].toString(), style: TextStyle(fontFamily: "SanPro", fontWeight: FontWeight.w500),),
          leading: Icon(list[index]["icon"] as IconData? , color: Colors.blue[600],),
          trailing: index != 3 ?
            Icon(Icons.arrow_forward_ios_outlined,  color: Colors.blue[300],) 
            :
            SizedBox(
              height: 30,
              width: 40,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                  activeColor: ThemeCustom.main_backgAppBar_v2,
                  value: autoSync,                   
                  onChanged:(value) {
                    setState(() {
                      autoSync = value;
                    });
                  },
                           
                ),
              ),
            )
            ,
          onTap: list[index]["function"] as Function(),
          
        ),
      ),
    );
  }
}