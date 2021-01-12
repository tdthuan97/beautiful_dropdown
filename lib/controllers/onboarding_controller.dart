import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdemo/models/onboarding_info.dart';
import 'package:getxdemo/views/home_page.dart';

class OnBoardingController extends GetxController {
  var selectedPageIndex = 0.obs;

  bool get isLastPage => selectedPageIndex.value == onBoardingPages.length - 1;

  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      Get.toNamed(HomePage.routeName + '?device=phone&id=354&name=Pepsi',
          arguments: 'Get is the best');
      // Get.bottomSheet(
      //     Container(
      //       child: Wrap(
      //         children: [
      //           ListTile(
      //             leading: Icon(Icons.wb_sunny_outlined),
      //             title: Text('Light Theme'),
      //             onTap: () => {Get.changeTheme(ThemeData.light())},
      //           ),
      //           ListTile(
      //             leading: Icon(Icons.wb_sunny),
      //             title: Text('Dark Theme'),
      //             onTap: () => {Get.changeTheme(ThemeData.dark())},
      //           )
      //         ],
      //       ),
      //     ),
      //     backgroundColor: Colors.white,
      //     isDismissible: true,
      //     enableDrag: true,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //         topRight: Radius.circular(8.0),
      //         topLeft: Radius.circular(8.0),
      //       ),
      //     ));
      // Get.defaultDialog();
      // Get.snackbar(
      //   'Snackbar Title', 'This is message',
      //   snackPosition: SnackPosition.BOTTOM,
      //   // messageText: Text(
      //   //   'Another Message',
      //   //   style: TextStyle(
      //   //     color: Colors.white,
      //   //   ),
      //   // ),
      //   colorText: Colors.red,
      //   backgroundColor: Colors.blue,
      //   borderRadius: 30,
      //   margin: EdgeInsets.all(10),
      //   // maxWidth: 200,
      //   // animationDuration: 2000.milliseconds,
      //   backgroundGradient:
      //       LinearGradient(colors: [Colors.orange, Colors.green]),
      //   borderColor: Colors.blue,
      //   borderWidth: 4,
      //   isDismissible: true,
      //   dismissDirection: SnackDismissDirection.HORIZONTAL,
      //   forwardAnimationCurve: Curves.bounceInOut,
      //   duration: 2000.milliseconds,
      //   icon: Icon(
      //     Icons.send,
      //     color: Colors.blue,
      //   ),
      //   // leftBarIndicatorColor: Colors.white,
      //   mainButton: FlatButton(
      //     child: Text('Retry'),
      //     color: Colors.blue,
      //     textColor: Colors.white,
      //     onPressed: () {},
      //   ),
      //   overlayBlur: 5,
      //   padding: EdgeInsets.all(10),
      //   // showProgressIndicator: true,
      //   snackbarStatus: (val) {
      //     print('status ' + val.toString());
      //   },
      //   // userInputForm: Form(
      //   //   child: Row(
      //   //     children: [
      //   //       Expanded(
      //   //         child: TextField(),
      //   //       )
      //   //     ],
      //   //   ),
      //   // ),
      // );
    } else {
      pageController.nextPage(
        duration: 300.milliseconds,
        curve: Curves.ease,
      );
    }
  }

  List<OnBoardingInfo> onBoardingPages = [
    OnBoardingInfo('assets/order.png', 'Order Your Food',
        'Now you can order food any time right from your mobile.'),
    OnBoardingInfo('assets/cook.png', 'Cooking Safe Food',
        'We are maintain safety and We keep clean while making food.'),
    OnBoardingInfo('assets/deliver.png', 'Quick Delivery',
        'Orders your favorite meals will be immediately deliver')
  ];

  @override
  void onInit() {
    print('INIT');
    super.onInit();
  }
}
