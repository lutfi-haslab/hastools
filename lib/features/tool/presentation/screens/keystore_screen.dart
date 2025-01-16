import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hastools/components/app_scaffold.dart';
import 'package:hastools/core/constants/color.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeystoreScreen extends StatefulWidget {
  const KeystoreScreen({super.key});

  @override
  State<KeystoreScreen> createState() => _KeystoreScreenState();
}

class _KeystoreScreenState extends State<KeystoreScreen> {
  final _formKey = GlobalKey<FormState>();
  final LocalAuthentication _localAuth = LocalAuthentication();
  final EncryptedSharedPreferences _encryptedPrefs = EncryptedSharedPreferences();
  static const String _keysListKey = 'keystore_keys_list';
  static const String _biometricsAvailableKey = 'biometrics_available';

  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  Map<String, String> _storedItems = {};
  Map<String, bool> _revealedValues = {};
  bool _isLoading = true;
  bool _canCheckBiometrics = false;

  @override
  void initState() {
    super.initState();
    _initializeBiometrics();
    _loadStoredItems();
  }

  Future<void> _initializeBiometrics() async {
    final prefs = await SharedPreferences.getInstance();
    bool? storedBiometricsAvailable = prefs.getBool(_biometricsAvailableKey);

    if (storedBiometricsAvailable == null) {
      try {
        final canCheck = await _localAuth.canCheckBiometrics;
        final hasAvailable = await _localAuth.getAvailableBiometrics();
        _canCheckBiometrics = canCheck && hasAvailable.isNotEmpty;
        await prefs.setBool(_biometricsAvailableKey, _canCheckBiometrics);
      } catch (e) {
        _canCheckBiometrics = false;
        await prefs.setBool(_biometricsAvailableKey, false);
      }
    } else {
      _canCheckBiometrics = storedBiometricsAvailable;
    }
    setState(() {});
  }

  Future<List<String>> _loadKeysList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keysListKey) ?? [];
  }

  Future<void> _saveKeysList(List<String> keys) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keysListKey, keys);
  }

  Future<void> _loadStoredItems() async {
    setState(() => _isLoading = true);
    try {
      final keys = await _loadKeysList();
      final Map<String, String> items = {};

      for (var key in keys) {
        final value = await _encryptedPrefs.getString(key);
        items[key] = value;
      }

      setState(() {
        _storedItems = items;
        _revealedValues = Map.fromIterables(
            items.keys, List.generate(items.length, (_) => false));
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading items: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    setState(() => _isLoading = false);
  }

  Future<void> _addItem() async {
    if (_formKey.currentState!.validate()) {
      final key = _keyController.text.trim();
      final value = _valueController.text.trim();

      try {
        await _encryptedPrefs.setString(key, value);
        final keys = await _loadKeysList();
        if (!keys.contains(key)) {
          keys.add(key);
          await _saveKeysList(keys);
        }

        await _loadStoredItems();
        _keyController.clear();
        _valueController.clear();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item stored successfully'),
              backgroundColor: AppColors.primary,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error storing item: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _deleteItem(String key) async {
    try {
      await _encryptedPrefs.remove(key);
      final keys = await _loadKeysList();
      keys.remove(key);
      await _saveKeysList(keys);
      await _loadStoredItems();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item deleted successfully'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error deleting item: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _toggleValueVisibility(String key) async {
    final currentlyRevealed = _revealedValues[key] ?? false;
    
    if (!currentlyRevealed && _canCheckBiometrics) {
      try {
        final didAuthenticate = await _localAuth.authenticate(
          localizedReason: 'Please authenticate to view the secure value',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          ),
        );

        if (!didAuthenticate) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Authentication failed'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Authentication error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }
    }

    setState(() {
      _revealedValues[key] = !currentlyRevealed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Secure Keystore",
      onBack: () => context.go("/tools"),
      child: Container(
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 2,
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _keyController,
                          decoration: InputDecoration(
                            labelText: 'Key',
                            labelStyle: const TextStyle(color: AppColors.textSecondary),
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.key, color: AppColors.primary),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter a key';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _valueController,
                          decoration: InputDecoration(
                            labelText: 'Value',
                            labelStyle: const TextStyle(color: AppColors.textSecondary),
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
                            suffixIcon: const Icon(Icons.visibility_off, color: AppColors.textSecondary),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter a value';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _addItem,
                          icon: const Icon(Icons.save, color: AppColors.white),
                          label: const Text(
                            'Store',
                            style: TextStyle(color: AppColors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Stored Items',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _storedItems.length,
                        itemBuilder: (context, index) {
                          final key = _storedItems.keys.elementAt(index);
                          final value = _storedItems[key] ?? '';
                          final isRevealed = _revealedValues[key] ?? false;

                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            color: AppColors.white,
                            child: ListTile(
                              leading: Icon(
                                _canCheckBiometrics
                                    ? Icons.fingerprint
                                    : Icons.security,
                                color: AppColors.primary,
                              ),
                              title: Text(
                                key,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                isRevealed ? value : '••••••••',
                                style: TextStyle(
                                  fontFamily: isRevealed ? null : 'monospace',
                                  color: AppColors.textSecondary,
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
                                      color: AppColors.primary,
                                    ),
                                    onPressed: () => _toggleValueVisibility(key),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
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
      ),
    );
  }
}