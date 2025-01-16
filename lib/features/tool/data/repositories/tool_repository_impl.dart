import 'dart:convert';
import 'package:hastools/features/tool/data/models/tool_model/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToolRepository {
  static const String _storageKey = 'tools';

  // Default tools list
  final List<Tool> _defaultTools = [
    Tool(
      name: 'Calculator',
      imageUrl: 'https://dummyimage.com/600x400/bdbdbd/ffffff.png',
      clickCount: 0,
      path: "/tool/calculator",
    ),
    Tool(
      name: 'Currency Converter',
      imageUrl: 'https://dummyimage.com/600x400/bdbdbd/ffffff.png',
      clickCount: 0,
      path: "/tool/currency-converter",
    ),
    Tool(
      name: 'Crypto Tools',
      imageUrl: 'https://dummyimage.com/600x400/bdbdbd/ffffff.png',
      clickCount: 0,
      path: "/tool/crypto-tools",
    ),
    Tool(
      name: 'Key Store',
      imageUrl: 'https://dummyimage.com/600x400/bdbdbd/ffffff.png',
      clickCount: 0,
      path: "/tool/keystore",
    ),
  ];

  Future<List<Tool>> fetchTools() async {
    final prefs = await SharedPreferences.getInstance();
    final toolsJson = prefs.getString(_storageKey);

    if (toolsJson == null) {
      // Save default tools to local storage
      await saveTools(_defaultTools);
      return _defaultTools;
    }

    final List<dynamic> decoded = jsonDecode(toolsJson);
    return decoded.map((json) => Tool.fromJson(json)).toList();
  }

  Future<void> saveTools(List<Tool> tools) async {
    final prefs = await SharedPreferences.getInstance();
    final toolsJson = jsonEncode(tools.map((tool) => tool.toJson()).toList());
    await prefs.setString(_storageKey, toolsJson);
  }

  Future<void> resetTools() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
