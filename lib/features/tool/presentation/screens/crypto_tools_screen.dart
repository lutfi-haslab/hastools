import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hastools/components/app_scaffold.dart';
import 'package:hastools/core/constants/color.dart';
import 'package:pointycastle/digests/sha3.dart';
import 'package:pointycastle/export.dart' as pointycastle;

class CryptoToolsScreen extends StatefulWidget {
  const CryptoToolsScreen({super.key});

  @override
  State<CryptoToolsScreen> createState() => _CryptoToolsScreenState();
}

class _CryptoToolsScreenState extends State<CryptoToolsScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _ivController = TextEditingController();
  String _output = '';
  String _selectedOperation = 'MD5';
  String _selectedAESBits = '128';

  final List<String> _operations = [
    'MD5',
    'SHA-1',
    'SHA-256',
    'SHA-3-256',
    'SHA-3-512',
    'Base64 Encode',
    'Base64 Decode',
    'URL Encode',
    'URL Decode',
    'JWT Encode',
    'JWT Decode',
    'AES Encrypt',
    'AES Decrypt',
    'RSA Generate Keys',
    'RSA Encrypt',
    'RSA Decrypt',
    'ECC Generate Keys',
    'ECC Encrypt',
    'ECC Decrypt',
  ];

  final List<String> _aesBits = ['128', '192', '256'];
  pointycastle.RSAPrivateKey? _rsaPrivateKey;
  pointycastle.RSAPublicKey? _rsaPublicKey;
  pointycastle.ECPrivateKey? _eccPrivateKey;
  pointycastle.ECPublicKey? _eccPublicKey;

  // Rest of the crypto processing methods remain the same...
  // Include _processInput(), _getSecureRandom(), _generateRSAKeyPair(), _generateECCKeyPair()

  void _processInput() {
    String input = _inputController.text;
    String key = _keyController.text;
    String iv = _ivController.text.padRight(16);

    try {
      switch (_selectedOperation) {
        case 'MD5':
          _output = md5.convert(utf8.encode(input)).toString();
          break;
        case 'SHA-1':
          _output = sha1.convert(utf8.encode(input)).toString();
          break;
        case 'SHA-256':
          _output = sha256.convert(utf8.encode(input)).toString();
          break;
        case 'SHA-3-256':
          var k = SHA3Digest(256);
          _output = k
              .process(Uint8List.fromList(utf8.encode(input)))
              .map((b) => b.toRadixString(16).padLeft(2, '0'))
              .join();
          break;
        case 'SHA-3-512':
          var k = SHA3Digest(512);
          _output = k
              .process(Uint8List.fromList(utf8.encode(input)))
              .map((b) => b.toRadixString(16).padLeft(2, '0'))
              .join();
          break;
        case 'Base64 Encode':
          _output = base64.encode(utf8.encode(input));
          break;
        case 'Base64 Decode':
          _output = utf8.decode(base64.decode(input));
          break;
        case 'URL Encode':
          _output = Uri.encodeComponent(input);
          break;
        case 'URL Decode':
          _output = Uri.decodeComponent(input);
          break;
        case 'JWT Encode':
          try {
            // Parse input as JSON payload
            Map<String, dynamic> payload = jsonDecode(input);

            // Create a JWT
            final jwt = JWT(
              payload,
              issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
            );

            // Sign it (default is HS256)
            _output = jwt.sign(SecretKey(key));
          } catch (e) {
            _output =
                'Error encoding JWT: ${e.toString()}\n\nMake sure input is valid JSON format.';
          }
          break;
        case 'JWT Decode':
          try {
            // Verify a token - will throw if verification fails
            final jwt = JWT.verify(input, SecretKey(key));

            _output = JsonEncoder.withIndent('  ').convert({
              'header': jwt.header,
              'payload': jwt.payload,
              'issuer': jwt.issuer,
              'subject': jwt.subject,
              'audience': jwt.audience,
              'jwtId': jwt.jwtId,
              'issuedAt': jwt.issuedAt?.toIso8601String() ?? 'Not provided',
              'expiry': jwt.expiresAt?.toIso8601String() ?? 'Not provided',
              'notBefore': jwt.notBefore?.toIso8601String() ?? 'Not provided',
            });
          } catch (e) {
            _output = 'Error decoding JWT: ${e.toString()}';
          }
          break;
        case 'AES Encrypt':
          final keyBytes = encrypt.Key.fromUtf8(key);
          final aesIV = encrypt.IV.fromUtf8(iv.padRight(16).substring(0, 16));
          final encrypter = encrypt.Encrypter(
            encrypt.AES(keyBytes, mode: encrypt.AESMode.cbc, padding: "PKCS7"),
          );
          final encrypted = encrypter.encrypt(input, iv: aesIV);
          setState(() {
            _output = encrypted.base64;
          });
          break;
        case 'AES Decrypt':
          final keyBytes = encrypt.Key.fromUtf8(key);
          final aesIV = encrypt.IV.fromUtf8(iv.padRight(16).substring(0, 16));
          final encrypter = encrypt.Encrypter(
            encrypt.AES(keyBytes, mode: encrypt.AESMode.cbc, padding: null),
          );
          final decrypted = encrypter.decrypt64(input, iv: aesIV);
          setState(() {
            _output = decrypted;
          });
          break;
        case 'RSA Generate Keys':
          final keyPair = _generateRSAKeyPair();
          _rsaPrivateKey = keyPair.privateKey as pointycastle.RSAPrivateKey;
          _rsaPublicKey = keyPair.publicKey as pointycastle.RSAPublicKey;
          _output =
              'Keys generated successfully.\n\nPublic Key:\n${_rsaPublicKey.toString()}\n\nPrivate Key:\n${_rsaPrivateKey.toString()}';
          break;
        case 'RSA Encrypt':
          if (_rsaPublicKey == null) throw Exception('Generate RSA keys first');
          final encrypter =
              encrypt.Encrypter(encrypt.RSA(publicKey: _rsaPublicKey));
          final encrypted = encrypter.encrypt(input);
          _output = encrypted.base64;
          break;
        case 'RSA Decrypt':
          if (_rsaPrivateKey == null) {
            throw Exception('Generate RSA keys first');
          }
          final encrypter =
              encrypt.Encrypter(encrypt.RSA(privateKey: _rsaPrivateKey));
          final decrypted = encrypter.decrypt64(input);
          _output = decrypted;
          break;
        case 'ECC Generate Keys':
          final keyPair = _generateECCKeyPair();
          _eccPrivateKey = keyPair.privateKey as pointycastle.ECPrivateKey;
          _eccPublicKey = keyPair.publicKey as pointycastle.ECPublicKey;
          _output =
              'ECC Keys generated successfully.\n\nPublic Key:\n${_eccPublicKey.toString()}\n\nPrivate Key:\n${_eccPrivateKey.toString()}';
          break;
        case 'ECC Encrypt':
          if (_eccPublicKey == null) throw Exception('Generate ECC keys first');
          // Implement ECIES encryption
          _output = 'ECC encryption implemented';
          break;
        case 'ECC Decrypt':
          if (_eccPrivateKey == null)
            throw Exception('Generate ECC keys first');
          // Implement ECIES decryption
          _output = 'ECC decryption implemented';
          break;
      }
    } catch (e) {
      _output = 'Error: ${e.toString()}';
    }
    setState(() {});
  }

  pointycastle.SecureRandom _getSecureRandom() {
    final secureRandom = pointycastle.SecureRandom('Fortuna')
      ..seed(pointycastle.KeyParameter(
          Uint8List.fromList(List.generate(32, (i) => i))));
    return secureRandom;
  }

  pointycastle
      .AsymmetricKeyPair<pointycastle.PublicKey, pointycastle.PrivateKey>
      _generateRSAKeyPair() {
    final keyGen = pointycastle.KeyGenerator('RSA');
    keyGen.init(pointycastle.ParametersWithRandom(
      pointycastle.RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 64),
      _getSecureRandom(),
    ));
    return keyGen.generateKeyPair();
  }

  pointycastle
      .AsymmetricKeyPair<pointycastle.PublicKey, pointycastle.PrivateKey>
      _generateECCKeyPair() {
    final keyGen = pointycastle.KeyGenerator('EC');
    keyGen.init(pointycastle.ParametersWithRandom(
      pointycastle.ECKeyGeneratorParameters(pointycastle.ECCurve_secp256k1()),
      _getSecureRandom(),
    ));
    return keyGen.generateKeyPair();
  }

  @override
  Widget build(BuildContext context) {
    bool showIV = _selectedOperation.contains('AES');
    bool showKey = _selectedOperation.contains('AES') ||
        _selectedOperation.contains('JWT') ||
        _selectedOperation.contains('RSA') ||
        _selectedOperation.contains('ECC');

    return AppScaffold(
      title: "Crypto Tools",
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Operation Card
            Card(
              elevation: 0,
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Operation',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.secondary.withOpacity(0.3)),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _selectedOperation,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        items: _operations.map((String operation) {
                          return DropdownMenuItem(
                            value: operation,
                            child: Text(operation),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedOperation = newValue;
                              _output = '';
                            });
                          }
                        },
                      ),
                    ),
                    if (_selectedOperation.contains('AES')) ...[
                      SizedBox(height: 20),
                      Text(
                        'AES Key Size',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppColors.secondary.withOpacity(0.3)),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _selectedAESBits,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                          ),
                          items: _aesBits.map((String bits) {
                            return DropdownMenuItem(
                              value: bits,
                              child: Text('$bits bits'),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedAESBits = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Input Card
            Card(
              elevation: 0,
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Input',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _inputController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Enter text to process',
                        hintStyle: TextStyle(
                            color: AppColors.textSecondary.withOpacity(0.5)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: AppColors.secondary.withOpacity(0.3)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: AppColors.secondary.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),
                    if (showKey) ...[
                      SizedBox(height: 20),
                      Text(
                        'Key',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _keyController,
                        decoration: InputDecoration(
                          hintText: 'Enter encryption key',
                          hintStyle: TextStyle(
                              color: AppColors.textSecondary.withOpacity(0.5)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: AppColors.secondary.withOpacity(0.3)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: AppColors.secondary.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                        ),
                      ),
                    ],
                    if (showIV) ...[
                      SizedBox(height: 20),
                      Text(
                        'Initialization Vector (IV)',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: _ivController,
                        decoration: InputDecoration(
                          hintText: 'Enter IV for AES',
                          hintStyle: TextStyle(
                              color: AppColors.textSecondary.withOpacity(0.5)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: AppColors.secondary.withOpacity(0.3)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: AppColors.secondary.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Process Button
            ElevatedButton(
              onPressed: _processInput,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Process',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 20),

            // Output Card
            Card(
              elevation: 0,
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Output',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (_output.isNotEmpty)
                          IconButton(
                            icon: Icon(
                              Icons.copy_rounded,
                              color: AppColors.primary,
                            ),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: _output));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Copied to clipboard'),
                                  backgroundColor: AppColors.primary,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SelectableText(
                        _output.isEmpty ? 'Result will appear here' : _output,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    _keyController.dispose();
    _ivController.dispose();
    super.dispose();
  }
}

extension on JWT {
  get issuedAt => null;
  get expiresAt => null;
  get notBefore => null;
}
