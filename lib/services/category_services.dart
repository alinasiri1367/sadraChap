import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sadra2/models/cat.dart';
import 'package:sadra2/models/product.dart';

class CategoryServices2 {
  static Future<dynamic> getData(int catId) async {
    final response =
        await http.post("http://sadra-chap.ir/api/v1/cats?id=${catId}");
    if (response.statusCode == 200) {
      var responsBody = json.decode(response.body)['data'];
      if (responsBody.length > 0) {
        if (responsBody.first['code'] == null) {
          List<Cat> cats = [];
          for (var c in responsBody) {
            cats.add(Cat.fromJson(c));
          }
          return {"list_type": "category", "lists": cats};
        } else {
          // print(jsonData['data']);
          List<Product> cats = [];
          for (var p in responsBody) {
            cats.add(Product.fromJson(p));
          }

          return {"list_type": "product", "lists": cats};
        }
      } else {
        return null;
      }
    }
  }
}
