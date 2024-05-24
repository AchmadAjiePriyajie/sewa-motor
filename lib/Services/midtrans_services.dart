import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MidtransService {
  static Future<String> getBaseUrl() async {
    bool isProduction = bool.parse(dotenv.get('MIDTRANS_IS_PRODUCTION'));
    Future<String> url = Future(
        () => isProduction ? 'app.midtrans.com' : 'app.sandbox.midtrans.com');
    return url;
  }

  static Future<String> createTransaction(Map<String, dynamic> params) async {
    String baseUrl = await getBaseUrl();
    var url = Uri.https(baseUrl, '/snap/v1/transactions');
    String serverKey = dotenv.get('MIDTRANS_SERVER_KEY');
    serverKey += ':';

    // String basicAuth = stringToBase64.decode(serverKey);
    Base64Codec base64 = const Base64Codec();
    String basicAuth = base64.encode(serverKey.codeUnits);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'midtrans-flutter',
      'Authorization': 'Basic $basicAuth'
    };
    var response =
        await http.post(url, headers: headers, body: jsonEncode(params));
    var data = jsonDecode(response.body);
    return Future(() => data['token']);
  }
}
