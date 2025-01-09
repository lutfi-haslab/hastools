import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static const String baseUrl = 'https://ctbsleqkryrucflnasbc.supabase.co/rest/v1';
  static  String apiKey = dotenv.get('ANNON_KEY');
  static  String authToken = 'Bearer ${dotenv.get('ANNON_KEY')}';
}