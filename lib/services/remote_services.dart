import 'package:getxdemo/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

// class UserProvider extends {
//   Future<List<dynamic>> getUser() async {
//     final response = await get('https://randomuser.me/api/?results=10');
//   }
// }
class RemoteServices {
  static var client = http.Client();

  static Future<List<Product>> fetchProducts() async {
    var response = await client.get(
        'http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline');
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      return null;
    }
  }
}

