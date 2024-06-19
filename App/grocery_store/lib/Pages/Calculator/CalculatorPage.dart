import 'package:flutter/material.dart';
import 'package:grocery_store/Component/AppBarCustom.dart';
import 'package:grocery_store/Component/ThemeCustom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expressions/expressions.dart';

class CalculatorPage extends StatefulWidget {
 
  CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {

  TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String result = '';
  List<String> history = [];
  Color bgColor = Colors.grey;
  Color textColor = Colors.white;


  @override
  void initState() {
    
    super.initState();
    _loadHistory();
    bgColor = ThemeCustom.cal_bgButton;
    textColor = ThemeCustom.cal_textButton;

  }

  void _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      history = prefs.getStringList('history') ?? [];
    });
  }

  void _saveHistory(String entry) async {
    final prefs = await SharedPreferences.getInstance();
    history.add(entry);
    await prefs.setStringList('history', history);
  }

  void _updateResult() {
    try {

      final expression = _controller.text;

      final resultValue = _calculate(expression);

      setState(() {
        result = resultValue.toString();
      });
    } catch (e) {
      setState(() {
        result = 'Error';
      });
    }

  }

  double _calculate(String expression) {
    if (expression.isEmpty) return 0;
    if (expression.length == 1) {
      if (double.tryParse(expression) == null) throw ArgumentError('Invalid expression');
      else return double.parse(expression);
    }
    
    // Hàm để tách các số và toán tử
    List<String> _splitExpression(String exp) {
      List<String> tokens = [];
      StringBuffer numBuffer = StringBuffer();
      for (int i = 0; i < exp.length; i++) {
        String char = exp[i];
        if ('0123456789.'.contains(char)) {
          numBuffer.write(char);
        } else {
          if (numBuffer.isNotEmpty) {
            tokens.add(numBuffer.toString());
            numBuffer.clear();
          }
          tokens.add(char);
        }
      }
      if (numBuffer.isNotEmpty) tokens.add(numBuffer.toString());
      return tokens;
    }
    
    // Hàm để thực hiện phép toán
    double _applyOperation(double a, double b, String op) {
      switch (op) {
        case '+':
          return a + b;
        case '-':
          return a - b;
        case 'x':
          return a * b;
        case '/':
          return a / b;
        default:
          throw ArgumentError('Invalid operator');
      }
    }
    
    List<String> tokens = _splitExpression(expression);

    // Xử lý phép nhân và chia trước
    List<String> newTokens = [];
    double currentValue = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length; i += 2) {
      String op = tokens[i];
      double nextValue = double.parse(tokens[i + 1]);
      if (op == 'x' || op == '/') {
        currentValue = _applyOperation(currentValue, nextValue, op);
      } else {
        newTokens.add(currentValue.toString());
        newTokens.add(op);
        currentValue = nextValue;
      }
    }
    newTokens.add(currentValue.toString());

    // Xử lý phép cộng và trừ
    currentValue = double.parse(newTokens[0]);
    for (int i = 1; i < newTokens.length; i += 2) {
      String op = newTokens[i];
      double nextValue = double.parse(newTokens[i + 1]);
      currentValue = _applyOperation(currentValue, nextValue, op);
    }

    return currentValue;
  }

  void _insertCharacter(String char) {
    final cursorPosition = _controller.selection.start < 0 ? 0 : _controller.selection.start ;
    setState(() {
      _controller.text = _controller.text.substring(0, cursorPosition) + char + _controller.text.substring(cursorPosition);
      _controller.selection = TextSelection.fromPosition(TextPosition(offset: cursorPosition + 1));
      _updateResult();
    });
    _scrollToEnd();
  }

  void _moveCursorLeft() {
    final cursorPosition = _controller.selection.start;
    if (cursorPosition > 0) {
      setState(() {
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: cursorPosition - 1));
      });     
    }
    _scrollToCursor();

  }

  void _moveCursorRight() {
    final cursorPosition = _controller.selection.start;
    if (cursorPosition < _controller.text.length) {
      setState(() {
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: cursorPosition + 1));
      });

    }
    _scrollToCursor();
   
  }

  void _deleteCharacter() {
    final cursorPosition = _controller.selection.start;
    if (cursorPosition > 0) {
      setState(() {
        _controller.text = _controller.text.substring(0, cursorPosition - 1) + _controller.text.substring(cursorPosition);
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: cursorPosition - 1));
        _updateResult();
      });
    }
  }

  void _clearAll() {
    setState(() {
      _controller.clear();
      result = '';
    });
  }

  void _evaluate() {
    setState(() {
      final evaluatedResult = result;
      _saveHistory('${_controller.text} = $evaluatedResult');
      _controller.text = evaluatedResult;
      _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
      result = '';
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
              child: Text('Xóa', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Hủy'),
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
  
  void _showHistory() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Lịch sử'),
          content: Container(
            width: double.maxFinite,
            height: 200.0,
            child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(history[index]),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: _showConfirmDialog,
              child: Text('Xóa', style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          color: ThemeCustom.cal_bgListButton,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Column(            
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [    
               IconButton(           
              icon: Icon(Icons.history, size: 35,),
              onPressed: _showHistory,
            ),        
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(                      
                      scrollController: _scrollController,
                      autofocus: true,
                      keyboardType: TextInputType.none,
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        
                      ),
                      style: TextStyle(fontSize: 24.0),
                      onChanged: (text) => _updateResult(),
                    ),
                    Text(
                      result,
                      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: _moveCursorLeft, icon: Icon(Icons.arrow_back_ios_new)),
                  IconButton(onPressed: _moveCursorRight, icon: Icon(Icons.arrow_forward_ios_sharp)),
                  IconButton(onPressed: _deleteCharacter, icon: Icon(Icons.backspace)),
                  IconButton(onPressed: _clearAll, icon: Icon(Icons.cleaning_services_rounded)),
                ],
              ),
              const SizedBox(height: 8.0),
              _buildButton( ['7', '8', '9', '/'] ),
              const SizedBox(height: 8.0),

              _buildButton( ['4', '5', '6', 'x'] ),
              const SizedBox(height: 8.0),

              _buildButton( ['1', '2', '3', '-'] ),                     
              const SizedBox(height: 8.0),

              Row(                            
                  children: ['0', '.', '=', '+']
                      .map((char) { 
                        if(char == "=")
                        {
                          bgColor = Colors.amber[800]!;
                          textColor = Colors.white;
                        }
                        else if(char == "+")
                        {
                          bgColor = Colors.blue[700]!;
                          textColor = Colors.white;
                        }
                        else 
                        {
                          bgColor = ThemeCustom.cal_bgButton;
                          textColor = Colors.black;
                        }                    
                        return Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: ElevatedButton(       
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: bgColor,
                                  fixedSize: Size(90, 60)   
                                  ),             
                                onPressed: char == '=' ? _evaluate : () => _insertCharacter(char),
                                child: Text(char, style: TextStyle(fontSize: 24.0, color: textColor)),
                              ),
                            ),
                          );
                        }
                      )
                      .toList(),
                ),            
            ],
          ),    
      
    );
  }

  _buildButton(List<String> list)
  {
    return  Row(
              children: list
                  .map((char)  
                  {                 
                    if(double.tryParse(char) == null && char != ".")
                    {
                      bgColor = Colors.blue[700]!;
                      textColor = Colors.white;
                    }
                    else 
                    {
                      bgColor = ThemeCustom.cal_bgButton;
                      textColor = Colors.black;
                    }

                    return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: bgColor,   
                              fixedSize: Size(90, 60)                           
                            ),
                            onPressed: () => _insertCharacter(char),
                            child: Text(char, style: TextStyle(fontSize: 24.0, color: textColor)),
                          ),
                        ),
                      );
                    })
                  .toList(),
            );
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void _scrollToCursor() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cursorPosition = _controller.selection.start;
      final TextSpan text = TextSpan(text: _controller.text, style: TextStyle(fontSize: 24.0));
      final TextPainter textPainter = TextPainter(
        text: text,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      double cursorX = textPainter.width;
      if (cursorPosition < _controller.text.length) {
        cursorX = textPainter.getOffsetForCaret(TextPosition(offset: cursorPosition), Rect.zero).dx;
      }
      
      double scrollPosition = cursorX - _scrollController.position.viewportDimension / 2;
      _scrollController.animateTo(
        scrollPosition,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

}
