import 'package:flutter/material.dart';
import 'package:hastools/components/app_scaffold.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD'; // Default from currency
  String _toCurrency = 'IDR'; // Default to currency (Indonesian Rupiah)
  double _result = 0.0;

  // Sample exchange rates (in real app, these would come from an API)
  final Map<String, double> _rates = {
    'USD': 1.0,
    'IDR': 15750.0, // Added IDR rate (approximate as of 2024)
    'EUR': 0.85,
    'GBP': 0.73,
    'JPY': 110.0,
    'AUD': 1.35,
  };

  final List<String> _currencies = [
    'USD',
    'IDR',
    'EUR',
    'GBP',
    'JPY',
    'AUD'
  ]; // Added IDR to the list

  void _convertCurrency() {
    if (_amountController.text.isEmpty) return;

    try {
      double amount = double.parse(_amountController.text);
      double result = amount * (_rates[_toCurrency]! / _rates[_fromCurrency]!);

      setState(() {
        _result = result;
      });
    } catch (e) {
      // Handle invalid input
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid input. Please enter a valid number.")),
      );
    }
  }

  void _swapCurrencies() {
    setState(() {
      String temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
    });
    _convertCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard when tapping outside
      },
      child: AppScaffold(
        title: "Currency Converter",
        backgroundColor: const Color(0xFF1E1E1E),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Currency\nConverter',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _amountController,
                        style: const TextStyle(color: Colors.white, fontSize: 24),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          hintText: 'Enter amount',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF3D3D3D),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCurrencyDropdown(_fromCurrency, (value) {
                              setState(() => _fromCurrency = value!);
                            }),
                          ),
                          GestureDetector(
                            onTap: _swapCurrencies,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.swap_horiz, color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: _buildCurrencyDropdown(_toCurrency, (value) {
                              setState(() => _toCurrency = value!);
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _convertCurrency,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      child: Text(
                        'Convert',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2C),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Result',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${_result.toStringAsFixed(2)} $_toCurrency',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown(
      String value, void Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF3D3D3D),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: _currencies.map((String currency) {
            return DropdownMenuItem<String>(
              value: currency,
              child: Text(
                currency,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: const Color(0xFF3D3D3D),
          style: const TextStyle(color: Colors.white),
          isExpanded: true,
        ),
      ),
    );
  }
}
