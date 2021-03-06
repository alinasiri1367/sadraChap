import 'dart:convert';
import 'package:http/http.dart' as http;

class PageServices {

  static Future<String> getPage(String page) async {

    final response = await http.get("http://sadra-chap.ir/api/v1/${page}");
    if (response.statusCode == 200) {
      var responsBody = json.decode(response.body)['data'];

      return responsBody['pic'];
    }
  }

}
