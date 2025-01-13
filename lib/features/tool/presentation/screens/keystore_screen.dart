import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hastools/components/app_scaffold.dart';

class KeystoreScreen extends StatefulWidget {
  const KeystoreScreen({super.key});

  @override
  State<KeystoreScreen> createState() => _KeystoreScreenState();
}

class _KeystoreScreenState extends State<KeystoreScreen> {
  final _formKey = GlobalKey<FormState>();
  final _storage = FlutterSecureStorage();
  static const String _pinKey = 'keystore_pin';

  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  Map<String, String> _storedItems = {};
  Map<String, bool> _revealedValues = {};
  bool _isLoading = true;
  String? _pin;

  @override
  void initState() {
    super.initState();
    _loadStoredItems();
    _loadPin();
  }

  Future<void> _loadPin() async {
    _pin = await _storage.read(key: _pinKey);
  }

  Future<void> _loadStoredItems() async {
    setState(() => _isLoading = true);
    try {
      _storedItems = await _storage.readAll();
      _revealedValues = Map.fromIterables(
          _storedItems.keys, List.generate(_storedItems.length, (_) => false));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading items: $e')),
      );
    }
    setState(() => _isLoading = false);
  }

  Future<void> _addItem() async {
    if (_formKey.currentState!.validate()) {
      final key = _keyController.text.trim();
      final value = _valueController.text.trim();

      try {
        await _storage.write(key: key, value: value);
        await _loadStoredItems();

        _keyController.clear();
        _valueController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item stored successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error storing item: $e')),
        );
      }
    }
  }

  Future<void> _deleteItem(String key) async {
    try {
      await _storage.delete(key: key);
      await _loadStoredItems();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting item: $e')),
      );
    }
  }

  Future<void> _toggleValueVisibility(String key) async {
    if (_pin == null) {
      _showSetPinDialog();
      return;
    }

    if (!(_revealedValues[key] ?? false)) {
      final bool verified = await _showPinVerificationDialog();
      if (!verified) return;
    }

    setState(() {
      _revealedValues[key] = !(_revealedValues[key] ?? false);
    });
  }

  Future<void> _showSetPinDialog() async {
    final TextEditingController pinController = TextEditingController();
    final TextEditingController confirmPinController = TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set PIN'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please set a PIN to reveal stored values'),
              SizedBox(height: 16),
              TextField(
                controller: pinController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter PIN',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: confirmPinController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm PIN',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (pinController.text.length != 4) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('PIN must be 4 digits')),
                  );
                  return;
                }
                if (pinController.text != confirmPinController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('PINs do not match')),
                  );
                  return;
                }
                await _storage.write(key: _pinKey, value: pinController.text);
                _pin = pinController.text;
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('PIN set successfully')),
                );
              },
              child: Text('Set PIN'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _showPinVerificationDialog() async {
    final TextEditingController pinController = TextEditingController();
    bool? result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter PIN'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: pinController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'PIN',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(pinController.text == _pin);
              },
              child: Text('Verify'),
            ),
          ],
        );
      },
    );

    if (result != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect PIN')),
      );
    }
    return result ?? false;
  }

  Future<void> _showResetPinDialog() async {
    if (_pin == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No PIN is currently set')),
      );
      return;
    }

    final bool verified = await _showPinVerificationDialog();
    if (!verified) return;

    _pin = null;
    await _storage.delete(key: _pinKey);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PIN reset successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Secure Keystore",
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _keyController,
                    decoration: InputDecoration(
                      labelText: 'Key',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.key),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a key';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _valueController,
                    decoration: InputDecoration(
                      labelText: 'Value',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.visibility_off),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _addItem,
                    icon: Icon(Icons.save),
                    label: Text('Store'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.security),
              onPressed: () =>
                  _pin == null ? _showSetPinDialog() : _showResetPinDialog(),
              tooltip: _pin == null ? 'Set PIN' : 'Reset PIN',
            ),
            SizedBox(height: 24),
            Text(
              'Stored Items',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _storedItems.length,
                      itemBuilder: (context, index) {
                        final key = _storedItems.keys.elementAt(index);
                        final value = _storedItems[key] ?? '';
                        final isRevealed = _revealedValues[key] ?? false;

                        return Card(
                          elevation: 2,
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: Icon(Icons.security),
                            title: Text(key),
                            subtitle: Text(
                              isRevealed ? value : '••••••••',
                              style: TextStyle(
                                fontFamily: isRevealed ? null : 'monospace',
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isRevealed
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () => _toggleValueVisibility(key),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteItem(key),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
