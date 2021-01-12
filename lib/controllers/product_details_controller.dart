import 'package:get/get.dart';
import 'package:getxdemo/controllers/product_controller.dart';
import 'package:getxdemo/models/product.dart';

class ProductDetailsController extends GetxController {
  ProductController productController = Get.find();

  var a = 1.obs;
  var b = 1.obs;
  var c = 1.obs;

  Product product;

  @override
  void onInit() {
    product = Get.arguments;
    super.onInit();
  }

  increment(String s) {
    if (s == 'a') {
      a += 1;
    } else if (s == 'b') {
      b += 1;
    } else if (s == 'c') {
      c += 1;
    } else if (s == 'e') {
      productController.totalAmount.value += 10.0;
      update();
    }
  }
}
