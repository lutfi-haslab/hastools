import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hastools/components/app_scaffold.dart';
import 'package:hastools/core/constants/color.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '';
  bool _isScientificMode = false;

  final List<String> _scientificOperations = [
    'sin',
    'cos',
    'tan',
    '√',
    '^2',
    '^',
    'ln',
    'log',
    'π',
    'e',
    '(',
    ')',
  ];

  final List<List<String>> _basicOperations = [
    ['C', '⌫', '%', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['±', '0', '.', '='],
  ];

  void _onButtonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'C':
          _input = '';
          _result = '';
          break;
        case '⌫':
          if (_input.isNotEmpty) {
            _input = _input.substring(0, _input.length - 1);
          }
          break;
        case '=':
          _calculateResult();
          break;
        case '±':
          if (_input.isNotEmpty) {
            if (_input.startsWith('-')) {
              _input = _input.substring(1);
            } else {
              _input = '-$_input';
            }
          }
          break;
        case 'sin':
        case 'cos':
        case 'tan':
        case 'log':
        case 'ln':
          _input += '$buttonText(';
          break;
        case 'π':
          _input += '3.14159';
          break;
        case 'e':
          _input += '2.71828';
          break;
        case '^2':
          _input += '^2';
          break;
        case '√':
          _input += 'sqrt(';
          break;
        default:
          _input += buttonText;
      }
    });
  }

  void _calculateResult() {
    try {
      String expression = _input;
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      expression = expression.replaceAll('√', 'sqrt');
      expression = expression.replaceAll('^', 'pow');

      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      if (eval % 1 == 0) {
        _result = eval.toInt().toString();
      } else {
        _result = eval
            .toStringAsFixed(8)
            .replaceAll(RegExp(r'0*$'), '')
            .replaceAll(RegExp(r'\.$'), '');
      }
    } catch (e) {
      _result = 'Error';
    }
  }

  Widget _buildButton(String text,
      {bool isOperator = false, bool isEqual = false}) {
    final double size = MediaQuery.of(context).size.width * 0.15;

    Color backgroundColor;
    Color textColor;

    if (isEqual) {
      backgroundColor = AppColors.primary;
      textColor = AppColors.white;
    } else if (isOperator) {
      backgroundColor = AppColors.secondary;
      textColor = AppColors.white;
    } else {
      backgroundColor = AppColors.white;
      textColor = AppColors.textPrimary;
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(size / 2),
          onTap: () => _onButtonPressed(text),
          child: Container(
            height: size,
            width: size,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 28,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScientificButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => _onButtonPressed(text),
          child: Container(
            height: 24,
            width: 60,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withBottomNavigation: false,
      onBack: () => context.go("/tools"),
      title: "Calculator",
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            // Scientific mode toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Scientific Mode',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                    value: _isScientificMode,
                    onChanged: (value) =>
                        setState(() => _isScientificMode = value),
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
            ),

            // Display
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _input,
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _result,
                      style: TextStyle(
                        fontSize: 30,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Scientific keypad
            if (_isScientificMode)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: _scientificOperations
                      .map((e) => _buildScientificButton(e))
                      .toList(),
                ),
              ),

            // Basic keypad
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: _basicOperations.map((row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: row.map((button) {
                      final bool isOperator =
                          ['+', '-', '×', '÷'].contains(button);
                      final bool isEqual = button == '=';
                      return _buildButton(
                        button,
                        isOperator: isOperator,
                        isEqual: isEqual,
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
