import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}
class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<String> _1571020270history = [];

  void _addToHistory(String entry) {
    setState(() {
      _1571020270history.add(entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _1571020270history.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_1571020270history[index]),
          );
        },
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
 _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  
  String _1571020177displayValue = '0';
  String _1571020177currentValue = '0';
  String _1571020177operand = '';
  double _1571020177result = 0;
  


  void _1571020177handleButtonClick(String buttonText) {
  setState(() {
    if (buttonText == 'C') {
      _1571020177clearAll();
    } else if (buttonText == '=') {
      _1571020177calculateResult();
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '×' ||
        buttonText == '÷') {
        
      if (_1571020177currentValue != '0') {
        _1571020177calculateResult();
        _1571020177setOperand(buttonText);
        _addToHistory('$_1571020177currentValue $_1571020177operand');
      } else {
        _1571020177setOperand(buttonText);
      }
      _1571020177setOperand(buttonText);
    } else if (buttonText == 'CE') {
      _1571020177clearEntry();
    } else if (buttonText == '.') {
      _1571020177handleDecimal();
    } else if (buttonText == '⌫') {
      _1571020177backspace();
    } else if (buttonText == '%') {
      _1571020177calculatePercentage();
    } else if (buttonText == 'x²') {
      _1571020177calculateSquare();
    } else if (buttonText == '√') {
      _1571020177calculateSquareRoot();
    } else if (buttonText == 'log') {
      _1571020177calculateLogarithm();
    } else if (buttonText == '+/-') {
      _1571020177toggleSign();
    } else {
      _1571020177handleNumber(buttonText);
    }

    // Display the current value and operand if applicable
    if (_1571020177operand.isNotEmpty) {
      _1571020177displayValue = '$_1571020177currentValue $_1571020177operand';
    } else {
      _1571020177displayValue = _1571020177currentValue;
    }
  });
}
  void _1571020177calculateSquare() {
    double currentValue = double.parse(_1571020177currentValue);
    _1571020177currentValue = (currentValue * currentValue).toString();
  }

  void _1571020177calculateSquareRoot() {
    double currentValue = double.parse(_1571020177currentValue);
    if (currentValue >= 0) {
      _1571020177currentValue = sqrt(currentValue).toString();
    } else {
      _1571020177displayValue = 'Error';
      return;
    }
  }

  void _1571020177calculateLogarithm() {
    double currentValue = double.parse(_1571020177currentValue);
    if (currentValue > 0) {
      _1571020177currentValue = log(currentValue).toString();
    } else {
      _1571020177displayValue = 'Error';
      return;
    }
  }

  void _1571020177toggleSign() {
    double currentValue = double.parse(_1571020177currentValue);
    _1571020177currentValue = (-currentValue).toString();
  }

  void _1571020177calculatePercentage() {
    double currentValue = double.parse(_1571020177currentValue);
    double resultAfterOperation;

    switch (_1571020177operand) {
      case '+':
        resultAfterOperation = _1571020177result + currentValue;
break;
      case '-':
        resultAfterOperation = _1571020177result - currentValue;
        break;
      case '×':
        resultAfterOperation = _1571020177result * currentValue;
        break;
      case '÷':
        if (currentValue != 0) {
          resultAfterOperation = _1571020177result / currentValue;
        } else {
          _1571020177displayValue = 'Error';
          return;
        }
        break;
      default:
        // If no operation, use currentValue as result
        resultAfterOperation = currentValue;
    }

    double percentageValue = resultAfterOperation * 0.01;
    _1571020177currentValue = percentageValue.toString();
    _1571020177operand = '';
  }

  void _1571020177clearAll() {
    _1571020177displayValue = '0';
    _1571020177currentValue = '0';
    _1571020177operand = '';
    _1571020177result = 0;
  }

  void _1571020177calculateResult() {
    if (_1571020177operand.isEmpty) {
      return; // No operand selected, nothing to calculate
    }

    double currentValue = double.parse(_1571020177currentValue);
    switch (_1571020177operand) {
      case '+':
        _1571020177result += currentValue;
        break;
      case '-':
        _1571020177result -= currentValue;
        break;
      case '×':
        _1571020177result *= currentValue;
        break;
      case '÷':
        if (currentValue != 0) {
          _1571020177result /= currentValue;
        } else {
          _1571020177displayValue = 'Error';
          return;
        }
        break;
    }

    _1571020177currentValue = _1571020177result.toString();
    _1571020177operand = '';
  }

  void _1571020177setOperand(String newOperand) {
    if (_1571020177operand.isNotEmpty) {
      _1571020177calculateResult();
      _1571020177operand = newOperand;
    } else {
      _1571020177operand = newOperand;
      _1571020177result = double.parse(_1571020177currentValue);
      _1571020177currentValue = '0';
    }
  }
void _addToHistory(String entry) {
  setState(() {
    var _1571020270history;
    _1571020270history.add(entry);
  });
}
  void _1571020177clearEntry() {
    _1571020177currentValue = '0';
  }

  void _1571020177handleDecimal() {
    if (!_1571020177currentValue.contains('.')) {
      _1571020177currentValue += '.';
    }
  }

  void _1571020177backspace() {
    if (_1571020177currentValue.length > 1) {
      _1571020177currentValue = _1571020177currentValue.substring(
          0, _1571020177currentValue.length - 1);
    } else {
      _1571020177currentValue = '0';
    }
  }

  void _1571020177handleNumber(String buttonText) {
    if (_1571020177currentValue == '0' || _1571020177currentValue == 'Error') {
      _1571020177currentValue = buttonText;
    } else {
      _1571020177currentValue += buttonText;
    }
  }

  Widget _1571020177buildButton(String buttonText,
      {Color color = Colors.white, Color textColor = Colors.black}) {
    return ElevatedButton(
      onPressed: () => _1571020177handleButtonClick(buttonText),
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor, backgroundColor: color,
padding: EdgeInsets.all(20.0),
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.black,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  _1571020177displayValue,
                  style: TextStyle(fontSize: 48.0, color: Colors.white),
                ),
              ),
            ),
          ),
          Divider(height: 0.0, color: Colors.grey),
          Row(
            children: [
              Expanded(child: _1571020177buildButton('C', color: Colors.white)),
              Expanded(
                  child: _1571020177buildButton('CE', color: Colors.white)),
              Expanded(child: _1571020177buildButton('%', color: Colors.white)),
              Expanded(child: _1571020177buildButton('⌫', color: Colors.white)),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: _1571020177buildButton('x²', color: Colors.white)),
              Expanded(child: _1571020177buildButton('√', color: Colors.white)),
              Expanded(
                  child: _1571020177buildButton('log', color: Colors.white)),
              Expanded(
                  child: _1571020177buildButton('+/-', color: Colors.white)),
            ],
          ),
          Row(
            children: [
              Expanded(child: _1571020177buildButton('7')),
              Expanded(child: _1571020177buildButton('8')),
              Expanded(child: _1571020177buildButton('9')),
              Expanded(child: _1571020177buildButton('÷', color: Colors.white)),
            ],
          ),
          Row(
            children: [
              Expanded(child: _1571020177buildButton('4')),
              Expanded(child: _1571020177buildButton('5')),
              Expanded(child: _1571020177buildButton('6')),
              Expanded(child: _1571020177buildButton('×', color: Colors.white)),
            ],
          ),
          Row(
            children: [
              Expanded(child: _1571020177buildButton('1')),
              Expanded(child: _1571020177buildButton('2')),
              Expanded(child: _1571020177buildButton('3')),
              Expanded(child: _1571020177buildButton('-', color: Colors.white)),
            ],
          ),
          Row(
            children: [
              Expanded(child: _1571020177buildButton('0')),
              Expanded(child: _1571020177buildButton('.')),
              Expanded(
                  child: _1571020177buildButton('=',
color: Colors.white, textColor: const Color.fromARGB(255, 33, 32, 32))),
              Expanded(
                  child: _1571020177buildButton('+',
                      color: Colors.white, textColor: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}