import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MidtransService {
  static Future<String> getBaseUrl() async {
    bool isProduction = dotenv.env['MIDTRANS_IS_PRODUCTION'] == 'true';
    return isProduction ? 'app.midtrans.com' : 'app.sandbox.midtrans.com';
  }

  static Future<String> createTransaction(Map<String, dynamic> params) async {
    String baseUrl = await getBaseUrl();
    var url = Uri.https(baseUrl, '/snap/v1/transactions');
    String serverKey = dotenv.env['MIDTRANS_SERVER_KEY'] ?? '';
    String basicAuth = base64Encode(utf8.encode('$serverKey:'));

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'midtrans-flutter',
      'Authorization': 'Basic $basicAuth',
    };

    var response = await http.post(url, headers: headers, body: jsonEncode(params));

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      return data['token'];
    } else {
      throw Exception('Failed to create transaction: ${response.body}');
    }
  }
}
