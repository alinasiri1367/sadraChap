import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sadra2/models/cat.dart';
import 'package:sadra2/models/page.dart';

class CategoryServices {
  static Future<List<Cat>> getMainCats() async {
    final response = await http.post("http://sadra-chap.ir/api/v1/cats");
    if (response.statusCode == 200) {
      var responsBody = json.decode(response.body)['data'];
      List<Cat> cats = [];
      responsBody.forEach(($item) {
        cats.add(Cat.fromJson($item));
      });
     return cats;
    }
  }

  static Future<Page> getPage(String query) async {
    final response = await http.get("http://sadra-chap.ir/api/v1/${query}");
    if (response.statusCode == 200) {
      var responsBody = json.decode(response.body)['data'];
      Page page = Page.fromJson(responsBody);
      return page;
    }
  }

}
