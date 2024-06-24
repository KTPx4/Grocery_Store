import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {

  Function clearAll;
  Function insertCharacter;
  Function scrollToEnd;
  History({super.key, 
  
  required this.scrollToEnd,
  required this.clearAll,
  required this.insertCharacter});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<String> history = [];
  @override
  void initState() {
    // TODO: implement initState
    loadHistory();
    super.initState();
  }

  void loadHistory() async
  {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      history = pref.getStringList("history") ?? [];
      
    });
  }

  void _clickHistory(String string)
  {
    widget.clearAll();
    var expression = string.split("=")[0].trim();
    widget.insertCharacter(expression);
    Navigator.of(context).pop(true);
    widget.scrollToEnd();
  }
  
  void _longpressHistory(int idx) async
  {
    history.removeAt(idx);
    var pref = await SharedPreferences.getInstance();
    pref.setStringList("history", history);
    setState(() {      
    });
  }

  void _showConfirmDialog() async {
    bool? confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có chắc chắn muốn xóa?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Xóa', style: TextStyle(color: Colors.red, fontFamily: "SanProBold")),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Hủy', style: TextStyle(color: Colors.black, fontFamily: "SanProBold")),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('history', []);
      setState(() {
        history = [];
      });
      Navigator.of(context).pop(true);
    }
  }
  
  @override
  Widget build(BuildContext context) {
   return AlertDialog(  
          backgroundColor: Color.fromARGB(255, 208, 226, 247),             
          title: Text('Lịch sử', style: TextStyle(color: Colors.black, fontFamily: "SanProBold"),),
          content: Container(                  
            width: double.maxFinite,
            height: 250.0,
            child: ListView.separated(                
              separatorBuilder: (context, index) => Divider(height: 1, color: Color.fromARGB(115, 133, 132, 132),),
              itemCount: history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(history[index]),
                  onTap: () => _clickHistory(history[index]),
                  onLongPress: () => _longpressHistory(index),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: _showConfirmDialog,
              child: Text('Xóa', style: TextStyle(color: Colors.red, fontFamily: "SanProBold"),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng', style: TextStyle(color: Colors.black, fontFamily: "SanProBold"),),
            ),
          ],
          );
  }
}