import 'dart:convert';
import 'package:http/http.dart' as http;

class ProtfolioServices {
  static Future<List<dynamic>> getProtfolios() async {
    final response = await http.get("http://sadra-chap.ir/api/v1/protfolio");
    if (response.statusCode == 200) {
      var responsBody = json.decode(response.body)['data'];
      return responsBody;
    }
  }
}
