import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdemo/controllers/product_controller.dart';
import 'package:getxdemo/controllers/product_details_controller.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = '/productDetailsPage';

  final ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    Widget appbar() {
      return AppBar(
        title: Text(productDetailsController.product.name),
      );
    }

    Widget body() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<ProductController>(builder: (controller) {
                return Text(controller.totalAmount.value.toString());
              }),
              GetBuilder<ProductDetailsController>(builder: (controller) {
                return Text('a ' + controller.a.value.toString());
              }),
              Obx(() {
                return Column(
                  children: [
                    Text('someValue ${Get.parameters['name']}'),
                    Text('someValue ${Get.arguments}'),
                    Text('A ${productDetailsController.a}'),
                    Text('B ${productDetailsController.b}'),
                    Text('C ${productDetailsController.c}'),
                    Text(
                        'D ${productDetailsController.productController.isGridView.value.toString()}'),
                    // Text(
                    //     'E ${productDetailsController.productController.totalAmount.value.toString()}'),
                    // GetBuilder(init:GetxController(),initState: (state){},builder: (controller) {
                    //   return Text(controller.isGridView.value.toString());
                    // }),
                  ],
                );
              }),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      productDetailsController.increment('a');
                    },
                    child: Text('A'),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      productDetailsController.increment('b');
                    },
                    child: Text('B'),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      productDetailsController.increment('c');
                    },
                    child: Text('C'),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    onPressed: () {
                      productDetailsController.increment('e');
                    },
                    child: Text('E'),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appbar(),
      body: body(),
    );
  }
}
