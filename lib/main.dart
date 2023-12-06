import 'package:flutter/material.dart';
import './eduview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '출석체크 키오스크',
      home: CheckInScreen(),
    );
  }
}

class NumberButton extends StatelessWidget {
  final String number;
  final Function(String) onPressed;

  NumberButton({required this.number, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(number),
      child: Container(
        width: 90.0,
        height: 90.0,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: number == 'del' ? Icon(Icons.backspace) : Text(
            number,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}


class CheckInScreen extends StatefulWidget {
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('출석 체크'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 번호 입력 필드
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              readOnly: true, // 터치로 입력 방지
              decoration: InputDecoration(
                labelText: '번호 뒷자리 입력',
              ),
              onTap: () {
                // 터치할 때 키보드 표시
                _showNumberKeyboard();
              },
            ),
            SizedBox(height: 20.0),
            // 숫자 버튼 키보드
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButton(number: '1', onPressed: _appendNumber),
                NumberButton(number: '2', onPressed: _appendNumber),
                NumberButton(number: '3', onPressed: _appendNumber),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButton(number: '4', onPressed: _appendNumber),
                NumberButton(number: '5', onPressed: _appendNumber),
                NumberButton(number: '6', onPressed: _appendNumber),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButton(number: '7', onPressed: _appendNumber),
                NumberButton(number: '8', onPressed: _appendNumber),
                NumberButton(number: '9', onPressed: _appendNumber),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButton(number: '확인', onPressed: _appendNumber),
                NumberButton(number: '0', onPressed: _appendNumber),
                NumberButton(number: 'del', onPressed: _deleteNumber),

                // 추가적인 기능을 위한 버튼 등 추가 가능
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showNumberKeyboard() {
    // 터치할 때 숫자 키보드를 표시하는 로직 추가
    // 여기서는 간단히 ScaffoldMessenger를 사용하여 SnackBar를 통해 표시
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('숫자 키보드를 터치하여 입력하세요.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _appendNumber(String number) {
    if (number == '확인') {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondPage()),);
    } else {
      setState(() {
        _inputController.text = _inputController.text + number;
      });
    }
  }
  void _deleteNumber(String _){
    setState(() {
      String currentText = _inputController.text;
      if (currentText.isNotEmpty) {
        _inputController.text = currentText.substring(0, currentText.length -1);
      }
    });
  }

}


