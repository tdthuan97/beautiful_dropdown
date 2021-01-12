import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdemo/models/drop_down_item.dart';
import 'package:getxdemo/models/product.dart';
import 'package:getxdemo/services/remote_services.dart';
import 'package:getxdemo/views/product_details_page.dart';
import 'package:getxdemo/widgets/custom_dropdown.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = List<Product>();

  var isGridView = true.obs;

  double get totalPrice =>
      productList.fold(0, (sum, item) => sum + double.parse(item.price));

  var totalAmount = 0.0.obs;

  //------
  var itemSelected = DropDownItem().obs;
  var list = List<DropDownItem>().obs;

  GlobalKey actionKey;
  double height, width, xPosition, yPosition;
  bool isDropdownOpened = false;
  OverlayEntry floatingDropdown;

  AnimationController animationController;

  @override
  void onInit() {
    // fetchProducts();
    onLoadDataListDropDown();
    super.onInit();
  }

  onLoadDataListDropDown() {
    list.add(DropDownItem.first(
      text: 'Add new',
      iconData: Icons.add_circle_outline,
      // isSelected: false,
    ));
    list.add(DropDownItem(
      text: 'View Profile',
      iconData: Icons.person_outline,
      // isSelected: false,
    ));
    list.add(DropDownItem(
      text: 'Settings',
      iconData: Icons.settings,
      // isSelected: false,
    ));
    list.add(DropDownItem(
      text: 'Ask a Question',
      iconData: Icons.question_answer,
      // isSelected: false,
    ));
    list.add(DropDownItem.last(
      text: 'Logout',
      iconData: Icons.exit_to_app,
      // isSelected: false,
    ));
    itemSelected.value = list[0];
    actionKey = LabeledGlobalKey(itemSelected.value.text);
  }

  void findDropDownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
    print('height ' + height.toString());
    print('width ' + width.toString());
    print('xPosition ' + xPosition.toString());
    print('yPosition ' + yPosition.toString());
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width,
        top: yPosition + height,
        height: list.length * height + 40,
        child: DropDown(
          animationController: animationController,
          itemSelected: itemSelected.value,
          list: list,
          onChanged: onChangedItem,
          itemHeight: height,
          backgroundColor: Colors.blue.shade600,
          backgroundColorSelected: Colors.blue.shade900,
        ),
      );
    });
  }

  onTapDropDown(BuildContext context) {
    // if (animationController.isDismissed) {
    //   animationController.forward();
    // } else {
    //
    // }
    if (isDropdownOpened) {
      animationController.reverse().whenComplete(() {
        floatingDropdown.remove();
        isDropdownOpened = !isDropdownOpened;
      });

      // animationController.reverse();
    } else {
      findDropDownData();

      floatingDropdown = _createFloatingDropdown();
      animationController.forward();
      Overlay.of(context).insert(floatingDropdown);
      isDropdownOpened = !isDropdownOpened;
    }
  }

  onChangedItem(DropDownItem _item) {
    itemSelected.value = _item;
    if (isDropdownOpened) {
      animationController.reverse().whenComplete(() {
        floatingDropdown.remove();
        isDropdownOpened = !isDropdownOpened;
      });
    }
  }

  onTapCard() {
    totalAmount.value += 1.0;
  }

  void onChangeView(bool isGrid) {
    if (isGrid) {
      isGridView(true);
    } else {
      isGridView(false);
    }
  }

  onTapItem(Product product) {
    Get.toNamed(ProductDetailsPage.routeName, arguments: product);
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productList = products;
        totalAmount.value = totalPrice;
      }
    } finally {
      isLoading(false);
    }
  }
}
