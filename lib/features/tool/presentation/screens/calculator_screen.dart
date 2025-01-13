import 'package:flutter/material.dart';
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
    '^',
    'log',
    'π',
    'e',
    '(',
    ')',
    '!',
    '%'
  ];

  final List<String> _basicOperations = [
    'C',
    '⌫',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '±',
    '0',
    '.',
    '='
  ];

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
        _result = '';
      } else if (buttonText == '⌫') {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
      } else if (buttonText == '=') {
        try {
          Parser parser = Parser();
          Expression exp =
              parser.parse(_input.replaceAll('×', '*').replaceAll('÷', '/'));
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          _result = eval.toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _input += buttonText;
      }
    });
  }

  Widget _buildButton(String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        color: color ?? const Color(0xFF292D36),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _onButtonPressed(text),
          child: Container(
            height: 65,
            width: 65,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 24,
                color: color != null ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
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
        elevation: 4,
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF393E46),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => _onButtonPressed(text),
          child: Container(
            height: 24,
            width: 40,
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
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
      title: "Calculator",
      child: Column(
        children: [
          // Toggle Switch for Scientific Mode
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Scientific Mode',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                  ),
                ),
                Switch(
                  value: _isScientificMode,
                  onChanged: (value) {
                    setState(() {
                      _isScientificMode = value;
                    });
                  },
                  activeColor: Colors.deepPurple,
                ),
              ],
            ),
          ),

          // Display
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _input,
                    style: const TextStyle(
                      fontSize: 48,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _result,
                    style: TextStyle(
                        fontSize: 24,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          // Scientific Keypad
          if (_isScientificMode)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: _scientificOperations
                    .map((e) => _buildScientificButton(e))
                    .toList(),
              ),
            ),

          // Basic Keypad
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF292D36),
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              children: [
                for (int i = 0; i < _basicOperations.length; i += 4)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int j = i;
                          j < i + 4 && j < _basicOperations.length;
                          j++)
                        _buildButton(
                          _basicOperations[j],
                          color: _getButtonColor(_basicOperations[j]),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color? _getButtonColor(String text) {
    if (text == 'C' || text == '⌫') {
      return Colors.redAccent;
    } else if (text == '=') {
      return Colors.deepPurpleAccent;
    } else if (text == '÷' || text == '×' || text == '-' || text == '+') {
      return Colors.amber;
    }
    return null;
  }
}
