import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getxdemo/controllers/product_controller.dart';
import 'package:getxdemo/views/product_tile.dart';
import 'package:getxdemo/widgets/custom_dropdown.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    productController.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget appbar() {
      return AppBar(
        backgroundColor: Colors.transparent,
        title:
            // Text(
            //   productController.totalPrice.toString(),
            //   style: TextStyle(color: Colors.blue),
            // ),
            Obx(() {
          return Text(
            productController.totalAmount.toString(),
            style: TextStyle(color: Colors.blue),
          );
        }),
        elevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                productController.onTapCard();
              })
        ],
      );
    }

    Widget body() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'ShopX',
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontSize: 32,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.view_list_rounded),
                    onPressed: () {
                      productController.onChangeView(false);
                    }),
                IconButton(
                    icon: Icon(Icons.grid_view),
                    onPressed: () {
                      productController.onChangeView(true);
                    }),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                return productController.isGridView.value
                    ? StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        itemCount: productController.productList.length,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        itemBuilder: (context, index) {
                          return ProductTile(
                              productController.productList[index], () {
                            productController.onTapItem(
                                productController.productList[index]);
                          });
                        },
                        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: productController.productList.length,
                        itemBuilder: (context, index) {
                          return ProductTile(
                              productController.productList[index], () {
                            productController.onTapItem(
                                productController.productList[index]);
                          });
                        },
                      );
            }),
          )
        ],
      );
    }

    return Scaffold(
      appBar: appbar(),
      body: Padding(
        padding: EdgeInsets.only(
          top: 48.0,
          left: 32.0,
          right: 32.0,
        ),
        child: Obx(
          () {
            return CustomDropdown(
              itemSelected: productController.itemSelected.value,
              list: productController.list,
              onTap: () {
                productController.onTapDropDown(context);
              },
              floatingDropdown: productController.floatingDropdown,
              width: productController.width,
              height: productController.height,
              xPosition: productController.xPosition,
              yPosition: productController.yPosition,
              actionKey: productController.actionKey,
              onChanged: productController.onChangedItem,
              backgroundColor: Colors.blue.shade600,
            );
          },
        ),
      ),
    );
  }
}
